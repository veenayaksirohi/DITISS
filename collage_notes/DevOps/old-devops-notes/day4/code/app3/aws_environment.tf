# vpc
resource "aws_vpc" "my_vpc" {

  # cidr ip4 for the vpc
  cidr_block = "10.0.0.0/16"

  # tenancy settings
  instance_tenancy = "default"

  # set the name for AWS
  tags = {
    Name = "my-vpc"
  }
}

# internet gateway
resource "aws_internet_gateway" "my_igw" {
  # vpc id
  vpc_id = aws_vpc.my_vpc.id

  # set the name for AWS
  tags = {
    Name = "my-igw"
  }
  
}

# route table
resource "aws_route_table" "rtb_public" {
  # vpc id
  vpc_id = aws_vpc.my_vpc.id

  # route for internet gateway
  route {
    # cidr block
    cidr_block = "0.0.0.0/0"

    # internet gateway
    gateway_id = aws_internet_gateway.my_igw.id
  }
  
  # name for AWS
  tags = {
    Name = "rtb-public"
  }
}

# public subnet
resource "aws_subnet" "subnet_public" {
  # vpc id for this subnet
  vpc_id = aws_vpc.my_vpc.id

  # cidr ip4 block
  cidr_block = "10.0.10.0/24"

  # allow public ip4 to instances
  map_public_ip_on_launch = true

  # set the name for AWS
  tags = {
    Name = "subnet-public"
  }
}

# associate the route table with the subnet created
resource "aws_route_table_association" "subnet_public_rtb_public" {
  # subnet id
  subnet_id = aws_subnet.subnet_public.id

  # route table id
  route_table_id = aws_route_table.rtb_public.id
}


# public subnet
resource "aws_subnet" "subnet_private" {
  # vpc id for this subnet
  vpc_id = aws_vpc.my_vpc.id

  # cidr ip4 block
  cidr_block = "10.0.20.0/24"

  # allow public ip4 to instances
  map_public_ip_on_launch = false

  # set the name for AWS
  tags = {
    Name = "subnet-private"
  }
}

# security group
resource "aws_security_group" "test_security_group" {
  name        = "test-security-group"
  description = "test security group for opening ssh port"
  vpc_id      = aws_vpc.my_vpc.id

  tags = {
    Name = "test-security-group"
  }
}

# security group ingress rule
resource "aws_vpc_security_group_ingress_rule" "allow_ssh" {
  security_group_id = aws_security_group.test_security_group.id
  ip_protocol       = "tcp"
  from_port         = 22
  to_port           = 22
  cidr_ipv4         = "0.0.0.0/0"
}

# security group egress rule
resource "aws_vpc_security_group_egress_rule" "allow_all" {
  security_group_id = aws_security_group.test_security_group.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1"
}

resource "aws_instance" "web-server" {
  # vpc id will be taken from subnet 
  subnet_id = aws_subnet.subnet_public.id

  # amazon machine image
  ami = "ami-0ecb62995f68bb549"

  # instance type
  instance_type = "t3.micro"

  # pem file name
  key_name = "aug25-batch"

  # security group ids
  vpc_security_group_ids = [

    # reference the id of security group created earlier
    aws_security_group.test_security_group.id
  ]

  # set the name in tags
  tags = {
    Name = "web-server"
  }
}

resource "aws_instance" "backend-server" {
  # vpc id will be taken from subnet 
  subnet_id = aws_subnet.subnet_private.id

  # amazon machine image
  ami = "ami-0ecb62995f68bb549"

  # instance type
  instance_type = "t3.micro"

  # pem file name
  key_name = "aug25-batch"

  # security group ids
  vpc_security_group_ids = [

    # reference the id of security group created earlier
    aws_security_group.test_security_group.id
  ]

  # set the name in tags
  tags = {
    Name = "backend-server"
  }
}