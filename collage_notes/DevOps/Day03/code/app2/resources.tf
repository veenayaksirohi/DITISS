# create a custom vpc
resource "aws_vpc" "main" {

  # set the cidr block
  cidr_block = "10.0.0.0/16"

  # set the tenancy
  instance_tenancy = "default"

  # set the vpc name
  tags = {

    # this will be used in management console
    Name = "myvpc"
  }
}

# create a public subnet
resource "aws_subnet" "public_subnet" {

    # specify the vpc id (read the id from aws_vpc resource named main)
    vpc_id = aws_vpc.main.id

    # specify the cidr block
    cidr_block = "10.0.10.0/24"

    # set the tags
    tags = {
      Name = "public-subnet"
    }
}

# create a private subnet
resource "aws_subnet" "private_subnet" {

    # specify the vpc id (read the id from aws_vpc resource named main)
    vpc_id = aws_vpc.main.id

    # specify the cidr block
    cidr_block = "10.0.20.0/24"

    # set the tags
    tags = {
      Name = "private-subnet"
    }
}