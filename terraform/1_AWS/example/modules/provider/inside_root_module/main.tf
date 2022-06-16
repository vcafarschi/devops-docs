provider "aws" {
  profile                 = "default"
  shared_credentials_file = "/Users/vladislav.cafarschi/.aws/credentials"
  region                  = "us-east-2"
}


terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 3.1.0"
    }
  }
}

module "test-module-no-provider" {
  source = "../../../../test_module_no_provider"

  ami = "ami-002068ed284fb165b"
  compute_type = "t2.micro"
  disable_api_termination = "true"
  ssh_key_name = "vcafarschi-us-east-2"
  instance_name = "test-instance"
  owner = "vcafarschi"
  user_data = "smth"
}