data "aws_ami" "jenkins" {
  #executable_users = ["938635207917"]
  most_recent      = true
  owners           = ["938635207917"]

  filter {
    name   = "name"
    values = ["ubuntu-appserver*"]
  }
}
