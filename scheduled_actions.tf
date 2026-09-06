resource "aws_autoscaling_schedule" "business_hours" {
  scheduled_action_name  = "${var.project_name}-business-hours-scale-up"
  autoscaling_group_name = aws_autoscaling_group.this.name

  recurrence       = var.business_hours_start_cron
  min_size         = var.business_hours_min_size
  max_size         = var.business_hours_max_size
  desired_capacity = var.business_hours_desired_capacity
}

resource "aws_autoscaling_schedule" "off_hours" {
  scheduled_action_name  = "${var.project_name}-off-hours-scale-down"
  autoscaling_group_name = aws_autoscaling_group.this.name

  recurrence       = var.business_hours_end_cron
  min_size         = var.off_hours_min_size
  max_size         = var.off_hours_max_size
  desired_capacity = var.off_hours_desired_capacity
}
