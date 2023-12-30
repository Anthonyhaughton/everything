resource "aws_launch_template" "dev_launch_template" {
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

  key_name = "dev_key"

  monitoring {
    enabled = true
  }

  network_interfaces {
    associate_public_ip_address = true
    security_groups             = [aws_security_group.dev_public_sg.id] # SG needs to be defined here or apply will fail.

  }

  tag_specifications {
    resource_type = "instance"

    tags = {
      Name = "webserver"
    }
  }

  user_data = filebase64("./docs/userdata.tpl") # pass script to install on the intanance 
}


# Create ASG 
resource "aws_autoscaling_group" "dev_asg" {
  name                 = "dev_asg"
  desired_capacity     = 4
  max_size             = 8
  min_size             = 4
  termination_policies = ["OldestInstance"]         # This will delete the oldest instance when it scales down
  vpc_zone_identifier  = module.dev-vpc.subnet_ids # You can go into outputs.tf and see all the options I tried to get this to work. The solution ended up being remove the brackets. All options worked once doing that 

  health_check_type   = "ELB"
  health_check_grace_period = 300

  launch_template {
    id      = aws_launch_template.dev_launch_template.id
    version = "$Latest"
  }
}

# Create a new ALB Target Group attachment
# This was the missing part that registers the EC2 machines inside of the ASG to the ALB so
# that it can forward whatever traffic the webserver is displaying.

resource "aws_autoscaling_attachment" "asg_attach_to_alb" {
  autoscaling_group_name = aws_autoscaling_group.dev_asg.id
  lb_target_group_arn    = aws_lb_target_group.dev_target_group.arn
}

# Create ALB 
resource "aws_lb" "dev_alb" {
  name               = "dev-lb-tf"
  internal           = false # I believe this decides if it's internet facing or not.
  load_balancer_type = "application" # can be application or network.
  security_groups    = [aws_security_group.dev_public_sg.id]
  subnets            = module.dev-vpc.subnet_ids # "module.lamp-vpc.subnet_ids is tuple with 4 elements" -> solution = remove brackets

  enable_deletion_protection = false # If this is true terraform won't be able to destroy it.

  tags = {
    Project     = module.dev-vpc.project
    Environment = module.dev-vpc.environment
    ManagedBy   = module.dev-vpc.managedby
  }
}

# Create a TG so the ALB can find the webservers 
resource "aws_lb_target_group" "dev_target_group" {
  name        = "dev-target-group"
  port        = 80
  protocol    = "HTTP"
  target_type = "instance"
  vpc_id      = module.dev-vpc.vpc_id

  health_check {
    path                = "/"   # Use the root path for health checks
    port                = 80
    protocol            = "HTTP"
    interval            = 30
    timeout             = 5
    healthy_threshold   = 2
    unhealthy_threshold = 2
  }
}

# Create a listener so that the ALB can forward traffic from the webservers.
resource "aws_lb_listener" "dev_listener" {
  load_balancer_arn = aws_lb.dev_alb.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward" # This is what forwards the traffic from the EC2 instances to the alb
    target_group_arn = aws_lb_target_group.dev_target_group.arn
  }
}
