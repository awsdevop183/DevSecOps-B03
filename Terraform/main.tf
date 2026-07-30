resource "aws_vpc" "terraform-vpc" {
  cidr_block           = var.vpc-cidr
  enable_dns_hostnames = true
  tags = {
    Name = "Terraform-vpc"
  }

}



resource "aws_internet_gateway" "igw" {

  vpc_id = aws_vpc.terraform-vpc.id

}


# resource "aws_subnet" "sub-1" {
#   # cidr_block = var.cidrs[0]

#   cidr_block = var.subnets[0]
#   vpc_id     = aws_vpc.test.id
#   tags = {
#     Name = "Sub-1"
#   }

# }


# resource "aws_subnet" "sub-2" {
#   cidr_block = var.subnets[1]

#   vpc_id = aws_vpc.test.id
#   tags = {
#     Name = "Sub-2"
#   }

# }

# resource "aws_subnet" "sub-3" {
#   cidr_block = var.subnets[2]

#   vpc_id = aws_vpc.test.id
#   tags = {
#     Name = "Sub-3"
#   }
#   lifecycle {
#     # create_before_destroy = true
#     # prevent_destroy = true
#   }
# }



# resource "aws_subnet" "subnets" {
#   vpc_id     = aws_vpc.test.id
#   count      = length(var.subnets)
#   cidr_block = var.subnets[count.index]
#   tags = {
#     Name = "Terraform-subnet-${count.index + 1}"
#   }

# }





resource "aws_subnet" "subnets" {
  vpc_id     = aws_vpc.terraform-vpc.id
  for_each   = var.subnets
  cidr_block = each.value

  tags = {
    Name = "Terraform-${each.key}"
  }

}













resource "local_file" "test" {
  filename = "vpc_id.txt"
  content  = "My VPC id is: ${aws_vpc.terraform-vpc.id}..."

  depends_on = [aws_internet_gateway.igw]

}



# data "aws_vpc" "application-vpc" {
#   id = "vpc-04f8c3738c469293f"
# }

# resource "aws_subnet" "app-sub" {

#   vpc_id     = data.aws_vpc.application-vpc.id
#   cidr_block = "10.0.180.0/24"


# }



# main.tf  - resource block (VPC)
# variables.tf  - declare variables
# dev.tfvars   - assign variables values
# terraform apply -var-file dev.tfvars

# terraform.tfvars

# terraform apply









# resource "aws_internet_gateway" "igw" {

#   vpc_id = aws_vpc.test.id

# }

# resource "aws_s3_bucket" "test" {
#   bucket = "bunnyops-3"
# }

# Immutable: we cannot modify the resource

# Mutable: we can modify







# Arguments = Inputs

# Attributes = Resource emitting values
# resource
# data



# resource "aws_vpc" "test" {
#   cidr_block = "192.168.0.0/16"
#   tags = {
#     Name = "Terraform-vpc"
#   }

# }


# aws_vpc  =
# AWS= provider
# vpc= Resource_type


# resource "aws_s3_bucket" "name" {

# }

# aws = provider
# s3_bucket = resource type

# name = resource name

# cidr_block = Arguments

