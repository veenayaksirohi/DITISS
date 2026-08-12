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

  # assign the public ipv4 automatically
  map_public_ip_on_launch = true

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

# create a security group for public instance
resource "aws_security_group" "sg_public" {
  # set the name
  name = "sg_public"

  # set the vpc_id
  vpc_id = aws_vpc.main.id

  # set the name for management console
  tags = {

    # name for management console
    Name = "sg-public"
  }
}

# add inbound rule to open port 80
resource "aws_vpc_security_group_ingress_rule" "port_80" {

  # set the security group
  security_group_id = aws_security_group.sg_public.id

  # set the cidr block
  cidr_ipv4 = "0.0.0.0/0"

  # set the port number
  from_port = 80

  # set the port number
  to_port = 80

  # set the protocol
  ip_protocol = "tcp"
}

# add inbound rule to open port 443
resource "aws_vpc_security_group_ingress_rule" "port_443" {

  # set the security group
  security_group_id = aws_security_group.sg_public.id

  # set the cidr block
  cidr_ipv4 = "0.0.0.0/0"

  # set the port number
  from_port = 443

  # set the port number
  to_port = 443

  # set the protocol
  ip_protocol = "tcp"
}

# open all ports for outbound
resource "aws_vpc_security_group_egress_rule" "outbound" {
  # set the security group
  security_group_id = aws_security_group.sg_public.id

  # set the cidr block
  cidr_ipv4 = "0.0.0.0/0"

  # set the protocol (semantically equivalent to all ports)
  ip_protocol = "-1"
}

# create a instance in public subnet
resource "aws_instance" "public_instance" {
  # set the ami
  ami = "ami-0ec10929233384c7f" # for NV region
  # ami = "ami-05d2d839d4f73aafb" # for mumbai region

  # set the name for management console
  tags = {

    # set the management console
    Name = "web-server"
  }

  # set the instance type
  instance_type = "t3.micro"

  # specify the key name
  key_name = "nv-test"

  # set the security group
  vpc_security_group_ids = [
    aws_security_group.sg_public.id
  ]

  # add this instance in public subnet
  subnet_id = aws_subnet.public_subnet.id
}


# create a instance in private subnet
resource "aws_instance" "private_instance" {
  # set the ami
  ami = "ami-0ec10929233384c7f" # for NV region
  # ami = "ami-05d2d839d4f73aafb" # for mumbai region

  # set the name for management console
  tags = {

    # set the management console
    Name = "db-server"
  }

  # set the instance type
  instance_type = "t3.micro"

  # specify the key name
  key_name = "nv-test"

  # add this instance in private subnet
  subnet_id = aws_subnet.private_subnet.id
}