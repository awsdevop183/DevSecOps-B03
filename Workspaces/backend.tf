terraform {
  backend "s3" {
    bucket       = "bunnyops-state"
    key          = "terraform-state/terraform.tfstate"
    region       = "us-east-1"
    use_lockfile = true
  }
}


# Old way of state locking using DynamoDB

# terraform {
#   backend "s3" {
#     bucket         = "terraform-state-bucket-26oct25"
#     key            = "terraform.tfstate"
#     region         = "us-east-1"
#     dynamodb_table = "tf-state-lock-table"
#     encrypt        = true
#   }
# }
