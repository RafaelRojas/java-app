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
  default     = "jenkins_key"
  description = "jenkins ssh key"
}

variable "jenkins_instance_type" {
  default     = "t2.micro"
  description = "jenkins instance type"
}

