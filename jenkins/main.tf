terraform {
  required_version = ">=0.11.0"
}

provider "aws" {
  region  = "${var.aws_region}"
  profile = "${var.aws_profile}"
}

module "network" {
  source = "../env/network"
}

resource "tls_private_key" "jenkins_key" {
  algorithm = "RSA"
  rsa_bits  = 2048
}

resource "aws_key_pair" "jenkins_keypair" {
  key_name   = "${var.app_key_name}"
  public_key = "${tls_private_key.jenkins_key.public_key_openssh}"
}

resource "aws_security_group" "jenkins_sg" {
  name        = "jenkins_sg"
  description = "Allows connection for Jenkins"
  vpc_id      = "${module.network.java-app_vpc}"

  #SSH
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  #Jenkins
  ingress {
    from_port   = 8080
    to_port     = 8080
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

resource "aws_launch_configuration" "jenkins_lcfg" {
  name                        = "jenkins_lcfg"
  image_id                    = "${var.image_id}"
  instance_type               = "${var.jenkins_instance_type}"
  key_name                    = "${aws_key_pair.jenkins_keypair.key_name}"
  security_groups             = ["${aws_security_group.jenkins_sg.id}"]
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

resource "aws_autoscaling_group" "jenkins" {
  name                      = "jenkins_asg"
  max_size                  = 1
  min_size                  = 1
  launch_configuration      = "${aws_launch_configuration.jenkins_lcfg.id}"
  vpc_zone_identifier       = ["${module.network.java-app_public_subnet}"]
  health_check_type         = "EC2"
  health_check_grace_period = 300

  lifecycle {
    create_before_destroy = true
  }

  tag {
    key                 = "Name"
    value               = "Jenkins"
    propagate_at_launch = true
  }
}
