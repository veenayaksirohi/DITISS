# terraform block
terraform {

  # required version to execute this script
  required_version = ">= 1.0.0"

  # list of providers used in the script
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "6.21.0"
    }
  }
}

# aws provider block
provider "aws" {
  # region = "ap-south-1"
  region = "us-east-1"
}

# resource block
resource "aws_instance" "web-server" {
  ami = "ami-0ecb62995f68bb549" # NV
  # ami = "ami-02b8269d5e85954ef" # mumbai
  instance_type = "t3.micro"
}