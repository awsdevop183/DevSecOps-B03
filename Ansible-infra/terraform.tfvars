region   = "us-east-1"
vpc-name = "ansible"
vpc-cidr = "10.0.0.0/16"

# Public subnets only - no private subnets, no NAT gateway
public-subnets = {
  "subnet-1" = "10.0.1.0/24"
  "subnet-2" = "10.0.2.0/24"
  "subnet-3" = "10.0.3.0/24"
}

key_name         = "ansible"
controller_key   = "MacbookAir"
private_key_path = "ansible.pem"
ssh_user         = "ubuntu"
centos-user      = "ec2-user"

controller_instance_type = "t3.medium"
node_instance_type       = "t3.small"
node_count               = 3

ssh_cidr = "0.0.0.0/0"

inventory_path  = "../Ansible/inventory"
ami             = "ami-0b6d9d3d33ba97d99"
amzon-linux-ami = "ami-0bdc7d025135d7b49"
