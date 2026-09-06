output "vpc_id" {
  value = aws_vpc.this.id
}

output "public_subnet_ids" {
  value = aws_subnet.public[*].id
}

output "launch_template_id" {
  value = aws_launch_template.this.id
}

output "autoscaling_group_name" {
  value = aws_autoscaling_group.this.name
}

output "scale_out_policy_arn" {
  description = "Simple scaling policy ARN (scale out on high CPU)"
  value       = aws_autoscaling_policy.scale_out_simple.arn
}

output "scale_in_policy_arn" {
  description = "Step scaling policy ARN (scale in on low CPU)"
  value       = aws_autoscaling_policy.scale_in_step.arn
}

output "high_cpu_alarm_name" {
  value = aws_cloudwatch_metric_alarm.high_cpu.alarm_name
}

output "low_cpu_alarm_name" {
  value = aws_cloudwatch_metric_alarm.low_cpu.alarm_name
}

output "ssm_connect_command" {
  description = "Example command to open a shell on an instance via SSM (replace INSTANCE_ID)"
  value       = "aws ssm start-session --target INSTANCE_ID --region ${var.aws_region}"
}
