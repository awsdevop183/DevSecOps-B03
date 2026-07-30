terraform {
  backend "s3" {
    bucket       = "bunnyops-state"
    key          = "terraform-state/terraform.tfstate"
    region       = "us-east-1"
    use_lockfile = true
  }
}
