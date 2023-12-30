# Create a scaling policy to increase # of intances. There is a CW alarm assoc with this.
resource "aws_autoscaling_policy" "asg_scale_up" {
  name                   = "server_scale_up"
  scaling_adjustment     = 1
  adjustment_type        = "ChangeInCapacity"
  cooldown               = 60
  autoscaling_group_name = aws_autoscaling_group.dev_asg.name
}

# Create a scaling policy to decrease # of intances. There is a CW alarm assoc with this.
resource "aws_autoscaling_policy" "asg_scale_down" {
  name                   = "server_scale_down"
  scaling_adjustment     = -1
  adjustment_type        = "ChangeInCapacity"
  cooldown               = 60
  autoscaling_group_name = aws_autoscaling_group.dev_asg.name
}

# Create CW Alarm. This alarm is what will trigger the scaling up.
resource "aws_cloudwatch_metric_alarm" "cw_scale_up" {
  alarm_name          = "cpuUtil_scaleUp"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = 1
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EC2"
  period              = 30
  statistic           = "Average"
  threshold           = 50

  dimensions = {
    AutoScalingGroupName = aws_autoscaling_group.dev_asg.name
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
  period              = 30
  statistic           = "Average"
  threshold           = 10
  treat_missing_data  = "notBreaching" # Treat missing data as "notBreaching" to avoid perpetual ALARM state 


  dimensions = {
    AutoScalingGroupName = aws_autoscaling_group.dev_asg.name
  }

  alarm_description = "This metric monitors ec2 cpu utilization and scales down"
  alarm_actions     = [aws_autoscaling_policy.asg_scale_down.arn]
}