variable "aws_region" {
  description = "AWS region to deploy into"
  type        = string
  default     = "us-east-1"
}

variable "project_name" {
  description = "Name prefix used to tag/name all resources"
  type        = string
  default     = "ansible-demo"
}

variable "environment" {
  description = "Environment tag applied to nodes (used as a dynamic inventory group)"
  type        = string
  default     = "training"
}

variable "key_name" {
  description = "Name of the existing EC2 key pair (already registered in this AWS account/region) used for SSH to both the controller and the nodes"
  type        = string
  default     = "ansible"
}

variable "node_instance_type" {
  description = "EC2 instance type for the ASG nodes"
  type        = string
  default     = "t3.micro"
}

variable "controller_instance_type" {
  description = "EC2 instance type for the Ansible controller"
  type        = string
  default     = "t3.medium"
}

variable "allowed_ssh_cidr" {
  description = "CIDR allowed to SSH into the controller and nodes on port 22"
  type        = string
  default     = "0.0.0.0/0"
}

variable "asg_min_size" {
  description = "Minimum number of EC2 instances in the Auto Scaling Group"
  type        = number
  default     = 3
}

variable "asg_desired_capacity" {
  description = "Desired number of EC2 instances in the Auto Scaling Group"
  type        = number
  default     = 3
}

variable "asg_max_size" {
  description = "Maximum number of EC2 instances in the Auto Scaling Group"
  type        = number
  default     = 5
}
