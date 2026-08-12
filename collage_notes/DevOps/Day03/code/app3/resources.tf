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

# create internet gateway
resource "aws_internet_gateway" "igw" {

  # set the vpc id (attach this igw to the required vpc)
  vpc_id = aws_vpc.main.id

  # set the name for management console
  tags = {

    # for management console
    Name = "internet-gateway"
  }
}

# create a public route table
resource "aws_route_table" "public_rt" {

  # set the vpc id
  vpc_id = aws_vpc.main.id

  # set the name for management console
  tags = {
    Name = "public-route-table"
  }

  # add the route table entries
  route {

    # set the cidr block
    cidr_block = "0.0.0.0/0"

    # set the gateway id
    gateway_id = aws_internet_gateway.igw.id
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

# associate the public route table with public subnet
resource "aws_route_table_association" "association_public" {
  # set the subnet id
  subnet_id = aws_subnet.public_subnet.id

  # set the route table id
  route_table_id = aws_route_table.public_rt.id
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