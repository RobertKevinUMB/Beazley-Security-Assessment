# VPC and Networking
resource "aws_vpc" "k8s_vpc" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_hostnames = true
  tags = {
    Name = "k8s-vpc"
  }
}

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
