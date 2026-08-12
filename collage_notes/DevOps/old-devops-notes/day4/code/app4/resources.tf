# vpc
resource "aws_vpc" "my_vpc" {
  cidr_block       = "10.0.0.0/16"
  instance_tenancy = "default"
  tags = {
    Name = "my-vpc"
  }
}

# internet gateway
resource "aws_internet_gateway" "my_igw" {
  vpc_id = aws_vpc.my_vpc.id
  tags = {
    Name = "my-igw"
  }
}

# route table
resource "aws_route_table" "rtb_public" {
  vpc_id = aws_vpc.my_vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.my_igw.id
  }
  tags = {
    Name = "rtb-public"
  }
}

# public subnet
resource "aws_subnet" "subnet_public" {
  vpc_id                  = aws_vpc.my_vpc.id
  cidr_block              = "10.0.10.0/24"
  map_public_ip_on_launch = true
  tags = {
    Name = "subnet-public"
  }
}

# private subnet
resource "aws_subnet" "subnet_private" {
  vpc_id     = aws_vpc.my_vpc.id
  cidr_block = "10.0.20.0/24"
  tags = {
    Name = "subnet-private"
  }
}

# route table association with subnet
resource "aws_route_table_association" "rtb_association" {
  subnet_id      = aws_subnet.subnet_public.id
  route_table_id = aws_route_table.rtb_public.id
}

# security group
resource "aws_security_group" "sg_test" {
  name        = "test security group"
  description = "used to test the ssh"
  vpc_id      = aws_vpc.my_vpc.id
  tags = {
    Name = "test security group"
  }
}

# security group ingress rule for ssh
resource "aws_vpc_security_group_ingress_rule" "allow_ssh" {
  security_group_id = aws_security_group.sg_test.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "tcp"
  from_port         = 22
  to_port           = 22
}

# security group ingress rule for http
resource "aws_vpc_security_group_ingress_rule" "allow_http" {
  security_group_id = aws_security_group.sg_test.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "tcp"
  from_port         = 80
  to_port           = 80
}

# security group ingress rule for https
resource "aws_vpc_security_group_ingress_rule" "allow_https" {
  security_group_id = aws_security_group.sg_test.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "tcp"
  from_port         = 443
  to_port           = 443
}

# security group egress rule
resource "aws_vpc_security_group_egress_rule" "allow_all" {
  security_group_id = aws_security_group.sg_test.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1"
}

# public instance
resource "aws_instance" "instance_public" {
  subnet_id              = aws_subnet.subnet_public.id
  ami                    = "ami-0ecb62995f68bb549"
  vpc_security_group_ids = [aws_security_group.sg_test.id]
  instance_type          = "t3.micro"
  key_name               = "aug25-batch"
  tags = {
    Name = "public instance"
  }
  user_data = <<EOF
    #!/bin/bash

    sudo apt-get update
    sudo apt-get install apache2 -y
    sudo systemctl enable apache2
    sudo systemctl start apache2
    sudo echo "<h1>Welcome to EC2 created by terraform</h1>" > /var/www/html/index.html
  EOF
}

# private instance
resource "aws_instance" "instance_private" {
  subnet_id              = aws_subnet.subnet_private.id
  ami                    = "ami-0ecb62995f68bb549"
  vpc_security_group_ids = [aws_security_group.sg_test.id]
  instance_type          = "t3.micro"
  key_name               = "aug25-batch"
  tags = {
    Name = "private instance"
  }
}