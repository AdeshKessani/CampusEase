terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "5.48.0"
    }
  }
  backend "s3" {
    bucket = "campusease-terraform-state"
    key    = "campusease-vpc-backend"
    region = "us-east-1"
    use_lockfile = true
  }
}

# Cloud provider connection (update with real credentials)
provider "aws" {
  region = "us-east-1"
}
