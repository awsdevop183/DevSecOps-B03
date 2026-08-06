vpc_cidr    = "172.16.0.0/16"
vpc_name    = "Terraform-Project"
public-subs = ["172.16.0.0/24", "172.16.1.0/24", "172.16.2.0/24"]

private-subs = ["172.16.10.0/24", "172.16.20.0/24", "172.16.30.0/24"]
azs          = ["us-east-1a", "us-east-1b", "us-east-1c"]

ami         = "ami-0b6d9d3d33ba97d99"
environment = "Development"
