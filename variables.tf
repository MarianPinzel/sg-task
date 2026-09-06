variable "aws_region" {
  description = "AWS region to deploy into"
  type        = string
  default     = "us-east-1"
}

variable "project_name" {
  description = "Name prefix used for tagging and naming all resources"
  type        = string
  default     = "sg-task-asg"
}

variable "vpc_cidr" {
  description = "CIDR block for the dedicated VPC"
  type        = string
  default     = "10.60.0.0/16"
}

variable "public_subnet_cidrs" {
  description = "CIDR blocks for the public subnets (one per AZ)"
  type        = list(string)
  default     = ["10.60.1.0/24", "10.60.2.0/24"]
}

variable "availability_zones" {
  description = "Availability zones to spread the ASG across. Leave empty to auto-select the first N AZs in the region."
  type        = list(string)
  default     = []
}

variable "instance_type" {
  description = "EC2 instance type for the autoscaling group (free-tier eligible)"
  type        = string
  default     = "t3.micro"
}

variable "key_name" {
  description = "Optional EC2 key pair name for SSH access. Leave null to rely on SSM Session Manager only."
  type        = string
  default     = null
}

variable "min_size" {
  description = "Minimum number of instances in the autoscaling group"
  type        = number
  default     = 1
}

variable "max_size" {
  description = "Maximum number of instances in the autoscaling group"
  type        = number
  default     = 4
}

variable "desired_capacity" {
  description = "Initial desired capacity of the autoscaling group"
  type        = number
  default     = 1
}

variable "target_cpu_utilization" {
  description = "Target average CPU utilization (%) is not used by the simple/step policies but kept for reference/testing"
  type        = number
  default     = 50
}

variable "high_cpu_threshold" {
  description = "CPU utilization (%) threshold that triggers scale-out (simple scaling policy)"
  type        = number
  default     = 70
}

variable "low_cpu_threshold" {
  description = "CPU utilization (%) threshold that triggers scale-in (step scaling policy)"
  type        = number
  default     = 20
}

variable "business_hours_start_cron" {
  description = "Cron expression (UTC) for scaling up at the start of business hours, Mon-Fri"
  type        = string
  default     = "0 8 * * MON-FRI"
}

variable "business_hours_end_cron" {
  description = "Cron expression (UTC) for scaling down at the end of business hours, Mon-Fri"
  type        = string
  default     = "0 18 * * MON-FRI"
}

variable "business_hours_min_size" {
  description = "Min size to apply during business hours"
  type        = number
  default     = 2
}

variable "business_hours_max_size" {
  description = "Max size to apply during business hours"
  type        = number
  default     = 4
}

variable "business_hours_desired_capacity" {
  description = "Desired capacity to apply during business hours"
  type        = number
  default     = 2
}

variable "off_hours_min_size" {
  description = "Min size to apply outside business hours"
  type        = number
  default     = 1
}

variable "off_hours_max_size" {
  description = "Max size to apply outside business hours"
  type        = number
  default     = 2
}

variable "off_hours_desired_capacity" {
  description = "Desired capacity to apply outside business hours"
  type        = number
  default     = 1
}

variable "tags" {
  description = "Common tags applied to all resources"
  type        = map(string)
  default     = {}
}
