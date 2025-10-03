terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.57"
    }
  }
  backend "s3" {
    bucket       = "campusease-terraform-state"
    key          = "campusease-dev-eks"
    region       = "us-east-1"
    use_lockfile = true
  }
}

provider "aws" {
  region = "us-east-1"
}
