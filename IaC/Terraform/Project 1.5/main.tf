# In 1.5 I will attempt to have a smaller main file so I will skip the providers file and just define the provider and account here.

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

module "vpc" {
    source = "./modules/vpc"

    #env = var.env
    vpc_cidr = "10.0.0.0/16"
}

