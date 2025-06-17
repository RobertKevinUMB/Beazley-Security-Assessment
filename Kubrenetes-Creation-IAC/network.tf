# network.tf
resource "aws_vpc" "k8s_vpc" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_hostnames = true
  tags = {
    Name = "k8s-vpc"
  }
}

# Internet Gateway for public connectivity
resource "aws_internet_gateway" "k8s_igw" {
  vpc_id = aws_vpc.k8s_vpc.id
  tags = {
    Name = "k8s-igw"
  }
}

# Public Route Table with default route to Internet Gateway
resource "aws_route_table" "public_rt" {
  vpc_id = aws_vpc.k8s_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.k8s_igw.id
  }

  tags = {
    Name = "k8s-public-rt"
  }
}

# Subnet Configuration with AZ Awareness
resource "aws_subnet" "k8s_subnets" {
  count                   = 3
  vpc_id                  = aws_vpc.k8s_vpc.id
  cidr_block              = "10.0.${count.index + 1}.0/24"
  availability_zone       = data.aws_availability_zones.available.names[count.index]
  map_public_ip_on_launch = true
  tags = {
    Name = "k8s-subnet-${count.index}"
  }
}

# Route Table Associations for All Subnets
resource "aws_route_table_association" "public_rta" {
  count          = 3
  subnet_id      = aws_subnet.k8s_subnets[count.index].id
  route_table_id = aws_route_table.public_rt.id
}

