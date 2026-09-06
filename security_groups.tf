resource "aws_security_group" "instance" {
  name_prefix = "instance-${var.project_name}-"
  description = "Security group for autoscaled instances (no inbound; SSM Session Manager for access)"
  vpc_id      = aws_vpc.this.id

  egress {
    description = "Allow all outbound traffic (required for SSM agent and package installs)"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = merge(local.common_tags, {
    Name = "${var.project_name}-instance-sg"
  })

  lifecycle {
    create_before_destroy = true
  }
}
