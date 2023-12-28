resource "aws_launch_template" "lamp_launch_template" {
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

  key_name = "lamp_key"

  monitoring {
    enabled = true
  }

  network_interfaces {
    associate_public_ip_address = true
    security_groups             = [aws_security_group.lamp_sg.id] # SG needs to be defined here or apply will fail.

  }

  tag_specifications {
    resource_type = "instance"

    tags = {
      Name = "webserver"
    }
  }

  user_data = filebase64("./docs/userdata.tpl") # pass script to install on the intanance 
}

resource "aws_lb" "lamp_alb" {
  name               = "lamp-lb-tf"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.lamp_sg.id]
  subnets            = module.lamp-vpc.subnet_ids # "module.lamp-vpc.subnet_ids is tuple with 4 elements" -> solution = remove brackets

  enable_deletion_protection = false

  tags = {
    Project     = "lamp"
    Environment = module.lamp-vpc.environment
    ManagedBy   = "terraform"
  }
}

resource "aws_lb_target_group" "lamp_target_group" {
  name        = "lamp-target-group"
  port        = 80
  protocol    = "HTTP"
  target_type = "instance"
  vpc_id      = module.lamp-vpc.vpc_id
}

resource "aws_lb_listener" "lamp_listener" {
  load_balancer_arn = aws_lb.lamp_alb.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type = "fixed-response"
    fixed_response {
      content_type = "text/plain"
      status_code  = "200"
      message_body = "OK"
    }
  }
}

resource "aws_lb_listener_rule" "lamp_listener_rule" {
  listener_arn = aws_lb_listener.lamp_listener.arn

  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.lamp_target_group.arn
  }

  condition {
    host_header {
      values = ["google.com"] # using google for this as I do not have my own site.
    }
  }
}
# Create ASG 
resource "aws_autoscaling_group" "lamp_asg" {
  name                 = "lamp_asg"
  desired_capacity     = 4
  max_size             = 8
  min_size             = 4
  termination_policies = ["OldestInstance"]         # This will delete the oldest instance when it scales down
  vpc_zone_identifier  = module.lamp-vpc.subnet_ids # You can go into outputs.tf and see all the options I tried to get this to work. The solution ended up being remove the brackets. All options worked once doing that 

  launch_template {
    id      = aws_launch_template.lamp_launch_template.id
    version = "$Latest"
  }
}

# Create a scaling policy to increase # of intances. There is a CW alarm assoc with this.
resource "aws_autoscaling_policy" "asg_scale_up" {
  name                   = "server_scale_up"
  scaling_adjustment     = 1
  adjustment_type        = "ChangeInCapacity"
  cooldown               = 60
  autoscaling_group_name = aws_autoscaling_group.lamp_asg.name
}

# Create a scaling policy to decrease # of intances. There is a CW alarm assoc with this.
resource "aws_autoscaling_policy" "asg_scale_down" {
  name                   = "server_scale_down"
  scaling_adjustment     = -1
  adjustment_type        = "ChangeInCapacity"
  cooldown               = 60
  autoscaling_group_name = aws_autoscaling_group.lamp_asg.name
}

# Create CW Alarm. This alarm is what will trigger the scaling up.
resource "aws_cloudwatch_metric_alarm" "cw_scale_up" {
  alarm_name          = "cpuUtil_scaleUp"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = 1
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EC2"
  period              = 60
  statistic           = "Average"
  threshold           = 50

  dimensions = {
    AutoScalingGroupName = aws_autoscaling_group.lamp_asg.name
  }

  alarm_description = "This metric monitors ec2 cpu utilization and scales up"
  alarm_actions     = [aws_autoscaling_policy.asg_scale_up.arn]
}

# Create CW Alarm. This alarm is what will trigger the scaling down.
resource "aws_cloudwatch_metric_alarm" "scale_down" {
  alarm_name          = "cpuUtil_scaleDown"
  comparison_operator = "LessThanOrEqualToThreshold"
  evaluation_periods  = 1
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EC2"
  period              = 60
  statistic           = "Average"
  threshold           = 10

  dimensions = {
    AutoScalingGroupName = aws_autoscaling_group.lamp_asg.name
  }

  alarm_description = "This metric monitors ec2 cpu utilization and scales down"
  alarm_actions     = [aws_autoscaling_policy.asg_scale_down.arn]
}