data "terraform_remote_state" "network" {
  backend = "s3"
  config = {
    bucket = "s3-javaapp-rafaelrojas7752"
    key    = "network/terraform.tfstate"
    region = "us-east-2"
  }
}
