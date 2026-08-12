# terraform block
terraform {

  # required version of terraform
  required_version = ">=1.0.0"

  # list of providers used
  required_providers {

    # use aws provider
    aws = {
      source  = "hashicorp/aws"
      version = "6.41.0"

      # credentials can be configured here, but it is always discouraged
      # region     = "us-east-1"
      # access_key = ""
      # secret_key = ""
    }
  }
}

# creates a new ec2 instance
resource "aws_instance" "web_server" {

  # this is for mumbai region
  # ami = "ami-05d2d839d4f73aafb"

  # this is for NV region
  ami = "ami-0ec10929233384c7f"

  # set the instance type
  instance_type = "t3.micro"

  # specify the key file used to ssh into the instance
  key_name = "nv-test"

  # set the name in the tags to appear in management console
  tags = {
    name = "web-server"
  }

}