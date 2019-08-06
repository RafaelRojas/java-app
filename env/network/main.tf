provider "aws" {
  region  = var.aws_region
  profile = var.aws_profile
}




###Uncomment when ready for S3 backend
terraform {
  backend "s3" {
    #encrypt        = true
    bucket         = "s3-javaapp-rafaelrojas7752"
    region         = "us-east-2"
    key            = "network/terraform.tfstate"
    dynamodb_table = "terraform-state-lock"
  }
}





data "aws_availability_zones" "available" {
  state = "available"
}

resource "aws_vpc" "java-app_vpc" {
  cidr_block           = var.vpc_cidr
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = {
    Name = "java-app_vpc"
  }
}

resource "aws_internet_gateway" "java-app_ig" {
  vpc_id = aws_vpc.java-app_vpc.id

  tags = {
    Name = "java-app_ig"
  }
}

resource "aws_route_table" "java-app_public_rt" {
  vpc_id = aws_vpc.java-app_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.java-app_ig.id
  }

  tags = {
    Name = "java-app_public_rt"
  }
}

resource "aws_default_route_table" "java-app_private_rt" {
  default_route_table_id = aws_vpc.java-app_vpc.default_route_table_id

  tags = {
    Name = "java-app_private_rt"
  }
}

resource "aws_subnet" "java-app_public_subnet" {
  vpc_id                  = aws_vpc.java-app_vpc.id
  cidr_block              = var.cidr_public
  map_public_ip_on_launch = true
  availability_zone       = data.aws_availability_zones.available.names[0]

  tags = {
    Name = "java-app_public_subnet"
  }
}

resource "aws_subnet" "java-app_private_subnet" {
  vpc_id                  = aws_vpc.java-app_vpc.id
  cidr_block              = var.cidr_private
  map_public_ip_on_launch = false
  availability_zone       = data.aws_availability_zones.available.names[1]

  tags = {
    Name = "java-app_private_subnet"
  }
}

resource "aws_subnet" "java-app_rds_subnet1" {
  vpc_id                  = aws_vpc.java-app_vpc.id
  cidr_block              = var.cidr_rds1
  map_public_ip_on_launch = false
  availability_zone       = data.aws_availability_zones.available.names[0]

  tags = {
    Name = "java-app_rds_subnet"
  }
}

resource "aws_subnet" "java-app_rds_subnet2" {
  vpc_id                  = aws_vpc.java-app_vpc.id
  cidr_block              = var.cidr_rds2
  map_public_ip_on_launch = false
  availability_zone       = data.aws_availability_zones.available.names[2]

  tags = {
    Name = "java-app_rds_subnet"
  }
}

resource "aws_db_subnet_group" "java-app_rds_sng" {
  name       = "java-app_rds_sng"
  subnet_ids = [aws_subnet.java-app_private_subnet.id, aws_subnet.java-app_rds_subnet1.id, aws_subnet.java-app_rds_subnet2.id]

  tags = {
    Name = "java-app_rds_sng"
  }
}

resource "aws_route_table_association" "java-app_public_assoc" {
  subnet_id      = aws_subnet.java-app_public_subnet.id
  route_table_id = aws_route_table.java-app_public_rt.id
}

resource "aws_route_table_association" "java-app_private_assoc" {
  subnet_id      = aws_subnet.java-app_private_subnet.id
  route_table_id = aws_default_route_table.java-app_private_rt.id
}


