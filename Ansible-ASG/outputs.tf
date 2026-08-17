output "alb_dns_name" {
  description = "Public DNS name of the ALB - open this in a browser"
  value       = aws_lb.node.dns_name
}

output "asg_name" {
  description = "Name of the Auto Scaling Group"
  value       = aws_autoscaling_group.node.name
}

output "key_name" {
  description = "Existing EC2 key pair used for SSH to the controller and nodes"
  value       = data.aws_key_pair.existing.key_name
}

output "controller_public_ip" {
  description = "Public IP of the Ansible controller EC2 instance"
  value       = aws_instance.controller.public_ip
}

output "controller_instance_id" {
  value = aws_instance.controller.id
}

output "aws_region" {
  value = var.aws_region
}

output "project_tag" {
  description = "Project tag used to filter nodes in the Ansible dynamic inventory"
  value       = var.project_name
}
