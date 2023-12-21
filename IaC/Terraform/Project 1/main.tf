# Create a VPC
resource "aws_vpc" "terra_vpc" {
  cidr_block           = "10.10.0.0/16"
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name = "project-vpc-01"
  }
}

# Create 4 subnets - 2 public 2 private
resource "aws_subnet" "pub_sub_a" {
  vpc_id                  = aws_vpc.terra_vpc.id
  cidr_block              = var.pub_sub_a_cidr
  availability_zone       = var.availability_zones[0]
  map_public_ip_on_launch = true

  tags = {
    Name = "public-subnet-a"
  }
}

resource "aws_subnet" "pub_sub_b" {
  vpc_id                  = aws_vpc.terra_vpc.id
  cidr_block              = var.pub_sub_b_cidr
  availability_zone       = var.availability_zones[1]
  map_public_ip_on_launch = true

  tags = {
    Name = "public-subnet-b"
  }
}

resource "aws_subnet" "priv_sub_a" {
  vpc_id                  = aws_vpc.terra_vpc.id
  cidr_block              = var.priv_sub_a_cidr
  availability_zone       = var.availability_zones[0]
  map_public_ip_on_launch = false

  tags = {
    Name = "private-subnet-a"
  }
}

resource "aws_subnet" "priv_sub_b" {
  vpc_id                  = aws_vpc.terra_vpc.id
  cidr_block              = var.priv_sub_b_cidr
  availability_zone       = var.availability_zones[1]
  map_public_ip_on_launch = false

  tags = {
    Name = "private-subnet-b"
  }
}

# Create IGW
resource "aws_internet_gateway" "terra_igw" {
  vpc_id = aws_vpc.terra_vpc.id

  tags = {
    Name = "project_igw"
  }
}

# Create Route Table
resource "aws_route_table" "terra_rt" {
  vpc_id = aws_vpc.terra_vpc.id

  tags = {
    Name = "public_rt"
  }
}

# Create route to IGW
resource "aws_route" "public_rt" {
  route_table_id         = aws_route_table.terra_rt.id
  destination_cidr_block = "0.0.0.0/0" # that IP is the whole internet
  gateway_id             = aws_internet_gateway.terra_igw.id
}

# Associate public subnets to public rt. How can I assoc 2 subnets in one block while also being able to tag them?
resource "aws_route_table_association" "public_a" {
  subnet_id      = aws_subnet.pub_sub_a.id
  route_table_id = aws_route_table.terra_rt.id
}

resource "aws_route_table_association" "public_b" {
  subnet_id      = aws_subnet.pub_sub_b.id
  route_table_id = aws_route_table.terra_rt.id
}

# Create public SG
resource "aws_security_group" "terra_sg" {
  name        = "public-sg"
  description = "Public sg to access the internet"
  vpc_id      = aws_vpc.terra_vpc.id

  ingress {
    description = "Allow All"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "public-sg"
  }
}

# Create key pair for EC2. In VSCode terminal; I ran "ssh-keygen.exe -t ed25519" 
resource "aws_key_pair" "terra_auth" {
  key_name   = "terra_key"
  public_key = file("~/.ssh/terra_key.pub") # I used the file func so that I can just point to the key rather than copy and paste the whole ed string
}

# Create Launch Template for ASG
resource "aws_launch_template" "terra_launch_template" {
  name = "web_server_template"

  block_device_mappings {
    device_name = "/dev/sdf"

    ebs {
      volume_size = 8
    }
  }

  capacity_reservation_specification {
    capacity_reservation_preference = "open"
  }

  image_id      = var.server_ami
  instance_type = "t2.micro"

  key_name = "terra_key"

  monitoring {
    enabled = true
  }

  network_interfaces {
    associate_public_ip_address = true
    security_groups             = [aws_security_group.terra_sg.id] # SG needs to be defined here or apply will fail.

  }

  tag_specifications {
    resource_type = "instance"

    tags = {
      Name = "webserver"
    }
  }

  user_data = filebase64("userdata.tpl") # pass script to install on the intanance 
}


# Create ASG 
resource "aws_autoscaling_group" "terra_asg" {
  name                 = "terra_asg"
  desired_capacity     = 1
  max_size             = 2
  min_size             = 1
  termination_policies = ["OldestInstance"] # This will delete the oldest instance when it scales down
  vpc_zone_identifier  = [aws_subnet.pub_sub_a.id, aws_subnet.pub_sub_b.id] # This is needed so that that it can depoly into both AZ's listed.

  launch_template {
    id      = aws_launch_template.terra_launch_template.id
    version = "$Latest"
  }
}

# Create a scaling policy to increase # of intances. There is a CW alarm assoc with this.
resource "aws_autoscaling_policy" "scale_up" {
  name                   = "server_scale_up"
  scaling_adjustment     = 1
  adjustment_type        = "ChangeInCapacity"
  cooldown               = 90
  autoscaling_group_name = aws_autoscaling_group.terra_asg.name
}

# Create a scaling policy to decrease # of intances. There is a CW alarm assoc with this.
resource "aws_autoscaling_policy" "scale_down" {
  name                   = "server_scale_down"
  scaling_adjustment     = -1
  adjustment_type        = "ChangeInCapacity"
  cooldown               = 90
  autoscaling_group_name = aws_autoscaling_group.terra_asg.name
}

# Create CW Alarm. This alarm is what will trigger the scaling up.
resource "aws_cloudwatch_metric_alarm" "scale_up" {
  alarm_name          = "cpuUtil_scaleUp"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = 2
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EC2"
  period              = 120
  statistic           = "Average"
  threshold           = 50

  dimensions = {
    AutoScalingGroupName = aws_autoscaling_group.terra_asg.name
  }

  alarm_description = "This metric monitors ec2 cpu utilization and scales up"
  alarm_actions     = [aws_autoscaling_policy.scale_up.arn]
}

# Create CW Alarm. This alarm is what will trigger the scaling down.
resource "aws_cloudwatch_metric_alarm" "scale_down" {
  alarm_name          = "cpuUtil_scaleDown"
  comparison_operator = "LessThanOrEqualToThreshold"
  evaluation_periods  = 2
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EC2"
  period              = 120
  statistic           = "Average"
  threshold           = 10

  dimensions = {
    AutoScalingGroupName = aws_autoscaling_group.terra_asg.name
  }

  alarm_description = "This metric monitors ec2 cpu utilization and scales down"
  alarm_actions     = [aws_autoscaling_policy.scale_down.arn]
}