variable "region" {

}

variable "vpc-cidr" {

}

variable "vpc-name" {

}

variable "public-subnets" {

}

variable "key_name" {

}

variable "controller_instance_type" {

}

variable "node_instance_type" {

}

variable "node_count" {

}

# Ubuntu login user, also written into the generated inventory
variable "ssh_user" {

}

# Private key on YOUR laptop, matching var.key_name
variable "private_key_path" {

}

# Who is allowed to SSH in. Narrow this to your IP/32 for a real class.
variable "ssh_cidr" {

}

# Where the generated Ansible inventory is written
variable "inventory_path" {

}
