provider "aws" {

  region = var.region

}

terraform {
  # required_version = ">= 1.14.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.4.0"
    }

    local = {
      source  = "hashicorp/local"
      version = "2.8.0"
    }

  }
}
