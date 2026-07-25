resource "aws_vpc" "name" {

  cidr_block = "192.168.0.0/16"
  tags = {
    "Name" = "Terraform-git-VPC"
  }
}


terraform {
  backend "s3" {
    bucket = "bunnyops"
    key    = "statefile"
    region = "us-east-1"
  }
}
