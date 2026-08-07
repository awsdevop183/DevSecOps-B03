vpc-name = "prod"
sg-name  = "prod-sg"
vpc-cidr = "10.0.0.0/16"
# cidrs    = ["10.0.0.0/24", "10.0.2.0/24", "10.0.1.0/24"]
# #            0                   1       2

# tuple-type = (["10.0.0.0/24", "10.0.1.0/24"])

public-subnets = {
  "subnet-1" = "10.0.0.0/24"
  "subnet-3" = "10.0.2.0/24"
  "subnet-4" = "10.0.3.0/24"
}


private-subnets = {
  "subnet-1" = "10.0.10.0/24"
  "subnet-3" = "10.0.20.0/24"
  "subnet-4" = "10.0.30.0/24"
}
key_name      = "MacbookAir"
instance_type = "t3.micro"
ami           = "ami-0b6d9d3d33ba97d99"





# dynamic block
# lookup
# workspaces
