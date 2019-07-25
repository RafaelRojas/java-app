data "aws_ami" "appserver" {
  #executable_users = ["938635207917"]
  most_recent      = true
  owners           = ["938635207917"]

  filter {
    name   = "name"
    values = ["ubuntu-appserver*"]
  }
}
