variable "aws_region" {
  description = "aws region to work on"
  default     = "us-east-2"
}

variable "aws_profile" {
  description = " AWS profile to use"
  default     = "rafael"
}

variable "vpc_cidr" {
  description = "vpc cidr to create"
  default     = "10.0.0.0/16"
}

variable "cidr_public" {
  description = "public subnet cidr"
  default     = "10.0.1.0/24"
}

variable "cidr_private" {
  description = "private subnet cidr"
  default     = "10.0.2.0/24"
}

variable "cidr_rds1" {
  description = "subnet for rds instance"
  default     = "10.0.5.0/24"
}

variable "cidr_rds2" {
  description = "subnet for rds instance"
  default     = "10.0.6.0/24"
}

