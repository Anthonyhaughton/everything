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

# Needed to create a vars.tf file in this folder to reference the ami. 
  image_id      = var.server_ami
  instance_type = "t2.micro"

  key_name = "terra_key"

  monitoring {
    enabled = true
  }

# Here is where outputs come into play. The only way to refernce the SG we created in the module was to use the
# "module.vpc..." using the normal "[aws_security_group.public.id]" will not work as it's not defined in the root
# module.

  network_interfaces {
    associate_public_ip_address = true
    security_groups             = [module.vpc.security_group_public]
  

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
  vpc_zone_identifier  = module.vpc.vpc_public_subnets 

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
resource "aws_cloudwatch_metric_alarm" "alarm_scale_up" {
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
resource "aws_cloudwatch_metric_alarm" "alarm_scale_down" {
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