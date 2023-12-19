# Define the AWS Provider and set a Region.If using VSCode, you need to define the the creds file and set the profile so that 
# an account can do the terraform actions.

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