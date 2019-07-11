variable "aws_region" {
  default     = "us-east-2"
  description = "default aws region"
}

variable "aws_profile" {
  default     = "rafael"
  description = "default aws profile"
}

variable "environment" {
  default     = "dev"
  description = "Environment to set up [dev|qa|prod]"
}

variable "app_key_name" {
  default     = "dbserver_key"
  description = "dbserver ssh key"
}

variable "db_instance_class" {
  default     = "db.t2.micro"
  description = "db instance type"
}

variable "dbname" {
  default     = "appserver_db"
  description = "db name default"
}

variable "dbuser" {
  default     = "administrator"
  description = "default admin id"
}

variable "dbpassword" {
  default     = "Change56Me!"
  description = "default database password, change it after provision!"
}
