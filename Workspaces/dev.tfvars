vpc-name = "dev"
sg-name  = "dev-sg"
vpc-cidr = "192.168.0.0/16"
#            0                   1       2

# tuple-type = (["192.168.0.0/24", "192.168.1.0/24"])

public-subnets = {
  "subnet-1" = "192.168.0.0/24"
  "subnet-3" = "192.168.2.0/24"
  "subnet-4" = "192.168.3.0/24"
}


private-subnets = {
  "subnet-1" = "192.168.10.0/24"
  "subnet-3" = "192.168.20.0/24"
  "subnet-4" = "192.168.30.0/24"
}
key_name      = "MacbookAir"
instance_type = "t3.micro"
ami           = "ami-0b6d9d3d33ba97d99"
# ami = "ami-01a00762f46d584a1"





# dynamic block
# lookup
# workspaces
