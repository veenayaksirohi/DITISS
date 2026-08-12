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
    }
  }
}
