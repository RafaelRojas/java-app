data "aws_ami" "appserver" {
  #executable_users = ["938635207917"]
  most_recent = true
  owners      = ["938635207917"]

  filter {
    name   = "name"
    values = ["ubuntu-appserver*"]
  }
}


data "terraform_remote_state" "network" {
  backend = "s3"
  config = {
     bucket = "s3-javaapp-rafaelrojas7752"
     key    = "network/terraform.tfstate"
     region = "us-east-2"
  }
}
