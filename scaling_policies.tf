resource "aws_autoscaling_policy" "scale_out_simple" {
  name                   = "${var.project_name}-scale-out-simple"
  autoscaling_group_name = aws_autoscaling_group.this.name
  policy_type            = "SimpleScaling"
  adjustment_type        = "ChangeInCapacity"
  scaling_adjustment     = 1
  cooldown               = 120
}

resource "aws_cloudwatch_metric_alarm" "high_cpu" {
  alarm_name          = "${var.project_name}-high-cpu"
  alarm_description   = "Average CPU >= ${var.high_cpu_threshold}% for 2 consecutive minutes"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = 2
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EC2"
  period              = 60
  statistic           = "Average"
  threshold           = var.high_cpu_threshold

  dimensions = {
    AutoScalingGroupName = aws_autoscaling_group.this.name
  }

  alarm_actions = [aws_autoscaling_policy.scale_out_simple.arn]
  tags          = local.common_tags
}

resource "aws_autoscaling_policy" "scale_in_step" {
  name                      = "${var.project_name}-scale-in-step"
  autoscaling_group_name    = aws_autoscaling_group.this.name
  policy_type               = "StepScaling"
  adjustment_type           = "ChangeInCapacity"
  estimated_instance_warmup = 120

  step_adjustment {
    metric_interval_lower_bound = -10
    metric_interval_upper_bound = 0
    scaling_adjustment          = -1
  }

  step_adjustment {
    metric_interval_upper_bound = -10
    scaling_adjustment          = -2
  }
}

resource "aws_cloudwatch_metric_alarm" "low_cpu" {
  alarm_name          = "${var.project_name}-low-cpu"
  alarm_description   = "Average CPU < ${var.low_cpu_threshold}% for 3 consecutive minutes"
  comparison_operator = "LessThanThreshold"
  evaluation_periods  = 3
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EC2"
  period              = 60
  statistic           = "Average"
  threshold           = var.low_cpu_threshold

  dimensions = {
    AutoScalingGroupName = aws_autoscaling_group.this.name
  }

  alarm_actions = [aws_autoscaling_policy.scale_in_step.arn]
  tags          = local.common_tags
}
