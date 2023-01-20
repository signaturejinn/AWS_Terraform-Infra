# VPC 생성
resource "aws_vpc" "vpc" {
  cidr_block       = "10.0.0.0/16"
  instance_tenancy = "default"

  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name = "smj-vpc"
  }
}


# Public Subnet
resource "aws_subnet" "pub_a" {
  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = "10.0.0.0/24"
  map_public_ip_on_launch = true  # 퍼블릭 IPv4 주소 자동할당 "Default is false"

  availability_zone = "ap-northeast-2a"

  tags = {
    Name = "tf-subnet-public1-ap-northeast-2a"
  }
}

resource "aws_subnet" "pub_c" {
  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = "10.0.2.0/24"
  map_public_ip_on_launch = true

  availability_zone = "ap-northeast-2c"

  tags = {
    Name = "tf-subnet-public2-ap-northeast-2c"
  }
}


# Private Subnet
resource "aws_subnet" "pri_a" {
  vpc_id     = aws_vpc.vpc.id
  cidr_block = "10.0.1.0/24"

  availability_zone = "ap-northeast-2a"

  tags = {
    Name = "tf-subnet-private1-ap-northeast-2a"
  }
}

resource "aws_subnet" "pri_c" {
  vpc_id     = aws_vpc.vpc.id
  cidr_block = "10.0.3.0/24"

  availability_zone = "ap-northeast-2c"

  tags = {
    Name = "tf-subnet-private2-ap-northeast-2c"
  }
}


#IGW
resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.vpc.id

  tags = {
    Name = "tf-igw"
  }
}


# Public Routing Table
resource "aws_route_table" "pub" {
  vpc_id = aws_vpc.vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw.id
  }

  tags = {
    Name = "tf-rtb-public"
  }
}


# public subnet & public route table association
resource "aws_route_table_association" "pub_a" {
  subnet_id      = aws_subnet.pub_a.id
  route_table_id = aws_route_table.pub.id
}

resource "aws_route_table_association" "pub_c" {
  subnet_id      = aws_subnet.pub_c.id
  route_table_id = aws_route_table.pub.id
}

# Private Route Table
resource "aws_route_table" "pri_a" {
  vpc_id = aws_vpc.vpc.id

/*  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.gw_a.id
  }
*/

  tags = {
    Name = "tf-rtb-private1-ap-northeast-2a"
  }
}

resource "aws_route_table" "pri_c" {
  vpc_id = aws_vpc.vpc.id

/*  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.gw_a.id
  }
*/

  tags = {
    Name = "tf-rtb-private3-ap-northeast-2c"
  }
}


# private_subnets & private_route_table association
resource "aws_route_table_association" "pri_a" {
  subnet_id      = aws_subnet.pri_a.id
  route_table_id = aws_route_table.pri_a.id
}

resource "aws_route_table_association" "pri_c" {
  subnet_id      = aws_subnet.pri_c.id
  route_table_id = aws_route_table.pri_c.id
}