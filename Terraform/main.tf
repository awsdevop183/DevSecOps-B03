resource "aws_vpc" "test" {
  cidr_block = "10.0.0.0/16"
  tags = {
    Name = "AWS_VPC"
  }

}


# resource "aws_s3_bucket" "test" {
#   bucket = "bunnyops-3"
# }

# Immutable: we cannot modify the resource

# Mutable: we can modify

resource "local_file" "test" {
  filename = "test.txt"
  content  = "Hello test file"

}

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

