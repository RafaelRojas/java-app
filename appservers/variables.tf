variable "aws_region" {
  default     = "us-east-2"
  description = "default aws region"
}

variable "aws_profile" {
  default     = "terraform-user"
  description = "default aws profile"
}

variable "environment" {
  default     = "dev"
  description = "Environment to set up [dev|qa|prod]"
}

variable "app_key_name" {
  default     = "appserver_key"
  description = "appserver ssh key"
}

variable "appserver_instance_type" {
  default     = "t2.micro"
  description = "appserver instance type"
}

variable "image_id" {
  default     = "ami-0122a2485ffbbba89"
  description = "appserver image AMI created to deploy server"
}

