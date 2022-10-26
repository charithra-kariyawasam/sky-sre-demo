#### Setting up the Terraform AWS Provider #####
terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "4.36.0"
    }
  }
}

#### Setting up the access to the AWS account via AWS given APIs ####
provider "aws" {
    region      = "us-east-1"
    shared_credentials_files = [ "C:\\Users\\cklze\\.aws\\credentials" ]
    profile = "default"
}

#### Declare the data source for available AWS AZs ####
data "aws_availability_zones" "available" {
  state = "available"
}