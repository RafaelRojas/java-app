provider "aws" {
  region  = var.aws_region
  profile = var.aws_profile
}

## Uncoment when ready to use s3 backend
#terraform {
#  backend "s3" {
#    bucket         = "s3-javaapp-rafaelrojas7752"
#    region         = "us-east-2"
#    key            = "dbserver/terraform.tfstate"
#    dynamodb_table = "terraform-state-lock"
#  }
#}



resource "tls_private_key" "dbserver_key" {
  algorithm = "RSA"
  rsa_bits  = 2048
}

resource "aws_key_pair" "dbserver_keypair" {
  key_name   = var.app_key_name
  public_key = tls_private_key.dbserver_key.public_key_openssh
}

resource "aws_security_group" "dbserver_sg" {
  name        = "dbserver_sg"
  description = "Allows connection for Database servers"
  vpc_id      = data.terraform_remote_state.network.outputs.java-app_vpc

  #SSH
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  #MYSQL
  ingress {
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  #ALL
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_default_subnet" "default_us-east-2a" {
  availability_zone = "us-east-2a"

  tags = {
    Name = "Default subnet for us-east-2a"
  }
}

resource "aws_db_instance" "appserver-db" {
  allocated_storage      = 20
  engine                 = "mysql"
  engine_version         = "5.6.40"
  instance_class         = var.db_instance_class
  name                   = "javaappdb"
  identifier             = "java-appdatabase"
  username               = var.dbuser
  password               = var.dbpassword
  db_subnet_group_name   = data.terraform_remote_state.network.outputs.java-app_rds_sng
  vpc_security_group_ids = [aws_security_group.dbserver_sg.id]
  skip_final_snapshot    = true
  publicly_accessible    = false
}

