# terraform block
terraform {

  # required version of terraform
  required_version = ">=1.14"

  # list of required providers
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "6.41.0"
    }
  }
}

resource "aws_instance" "web-server" {
  # AMI for ubuntu in NV region
  # ami = "ami-0ec10929233384c7f"

  # AMI for ubuntu in mumbai region
  ami = "ami-05d2d839d4f73aafb"
  
  instance_type = "t3.micro"

  tags = {
    Name = "web-server"
  }
}
