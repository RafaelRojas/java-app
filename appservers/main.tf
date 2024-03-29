provider "aws" {
  region  = var.aws_region
  profile = var.aws_profile
}


## Uncoment when ready to use s3 backend
terraform {
  backend "s3" {
    bucket         = "s3-javaapp-rafaelrojas7752"
    region         = "us-east-2"
    key            = "appserver/terraform.tfstate"
    dynamodb_table = "terraform-state-lock"
  }
}

##Use local backend for testing purposes
#data "terraform_remote_state" "network" {
#  backend = "local"

#  config = {
#    path = "../env/network/terraform.tfstate"
#  }
#}


resource "tls_private_key" "appkey" {
  algorithm = "RSA"
  rsa_bits  = 2048
}

resource "aws_key_pair" "app_key" {
  key_name   = var.app_key_name
  public_key = tls_private_key.appkey.public_key_openssh
}

resource "aws_launch_configuration" "java-app_lcfg" {
  name_prefix = "java-app_${var.environment}_lcfg"

  image_id                    = "${data.aws_ami.appserver.id}"
  instance_type               = var.appserver_instance_type
  key_name                    = aws_key_pair.app_key.key_name
  security_groups             = [aws_security_group.application_sg.id]
  associate_public_ip_address = true

  root_block_device {
    volume_size           = 25
    volume_type           = "standard"
    delete_on_termination = true
  }

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_autoscaling_group" "application" {
  name                      = "${var.environment}-application_asg"
  max_size                  = 3
  min_size                  = 1
  desired_capacity          = 3
  launch_configuration      = aws_launch_configuration.java-app_lcfg.id
  vpc_zone_identifier       = ["${data.terraform_remote_state.network.outputs.java-app_private_subnet}", "${data.terraform_remote_state.network.outputs.java-app_public_subnet}"]
  health_check_type         = "EC2"
  health_check_grace_period = 300

  lifecycle {
    create_before_destroy = true
  }

  tag {
    key                 = "Name"
    value               = "${var.environment}-app"
    propagate_at_launch = true
  }
}

resource "aws_security_group" "application_sg" {
  name        = "application_sg"
  description = "Allows connection for app layer"
  vpc_id      = data.terraform_remote_state.network.outputs.java-app_vpc

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

