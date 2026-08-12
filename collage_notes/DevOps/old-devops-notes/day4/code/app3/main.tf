terraform {
  required_version = ">= 1.0.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "6.22.0"
    }
  }
}

provider "aws" {
  region = "us-east-1"

  # note: do not expose the access key and secret here
  # instead export the environment variables in ~/.bashrc
  # export AWS_ACCESS_KEY_ID=
  # export AWS_SECRET_ACCESS_KEY=
  # export AWS_DEFAULT_REGION=ap-south-1

  # access_key = ""
  # secret_key = ""
}