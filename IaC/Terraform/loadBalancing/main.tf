terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
    }
  }
}

# Configure the AWS Provider
provider "aws" {
  region                   = "us-east-1"
  shared_credentials_files = ["~/.aws/credentials"]
  profile                  = "vscode"
}

module "dev-vpc" {
  source      = "./modules/vpc"
  environment = "dev"
  vpc_cidr    = "10.10.0.0/16"
}