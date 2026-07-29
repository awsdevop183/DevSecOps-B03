resource "aws_vpc" "test" {
  cidr_block           = var.vpc-cidr
  enable_dns_hostnames = true
  tags = {
    Name = var.objects.vpc_tags
  }

}



resource "aws_internet_gateway" "igw" {

  vpc_id = aws_vpc.test.id

}


resource "aws_subnet" "sub-1" {
  # cidr_block = var.cidrs[0]

  cidr_block = var.subnets["subnet-1"]
  vpc_id     = aws_vpc.test.id
  tags = {
    Name = "Sub-1"
  }

}


resource "aws_subnet" "sub-2" {
  # cidr_block = var.cidrs[1]
  # cidr_block = var.tuple-type[1]

  # cidr_block = var.subnets["subnet-2"]

  cidr_block = var.objects.cidrs[1]



  vpc_id = aws_vpc.test.id
  tags = {
    Name = "Sub-2"
  }

}


resource "local_file" "test" {
  filename = "vpc_id.txt"
  content  = "My VPC id is: ${aws_vpc.test.id}..."

  depends_on = [aws_internet_gateway.igw]

}





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

