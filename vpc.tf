# 1. The VPC
resource "aws_vpc" "main" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = {
    Name = "ultrastack-vpc"
  }
}

# 2. Public Subnets (for the Load Balancer)
resource "aws_subnet" "public" {
  count                   = 2
  vpc_id                  = aws_vpc.main.id
  cidr_block              = "10.0.${count.index}.0/24"
  availability_zone       = data.aws_availability_zones.available.names[count.index]
  map_public_ip_on_launch = true

  tags = {
    Name = "ultrastack-public-${count.index}"
  }
}

# 3. Private Subnets (for the Containers)
resource "aws_subnet" "private" {
  count             = 2
  vpc_id            = aws_vpc.main.id
  cidr_block        = "10.0.${count.index + 10}.0/24"
  availability_zone = data.aws_availability_zones.available.names[count.index]

  tags = {
    Name = "ultrastack-private-${count.index}"
  }
}

# 4. Internet Gateway (The Exit to the Web)
resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "ultrastack-igw"
  }
}

# 5. Data Source to get AZs
data "aws_availability_zones" "available" {
  state = "available"
}

