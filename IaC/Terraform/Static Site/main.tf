terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
    }
  }
}

# Configure the AWS Provider
provider "aws" {
  region                   = var.region
  shared_credentials_files = [var.cred_file]
  profile                  = var.profile
}

terraform {
  backend "s3" {
   bucket = "staticsite-tfstate"
   key    = "staticsite-state" #name of the S3 object that will store the state file
   region = "us-east-1"
 }
}
