provider "aws" {
  region  = var.aws_region
  profile = var.aws_profile
}
    
# Resource to create S3 bucket for storing remote state file
resource "aws_s3_bucket" "s3-javaapp-rafaelrojas7752" {
  bucket = "s3-javaapp-rafaelrojas7752"
  versioning {
    enabled = true
  }
  lifecycle {
    # Change to true on Prod
    prevent_destroy = false
  }
  tags = {
    Name = "Terraform S3 Remote State Store"
  }
}

resource "aws_dynamodb_table" "terraform-state-lock" {
  name           = "terraform-state-lock"
  hash_key       = "LockID"
  read_capacity  = 20
  write_capacity = 20
  attribute {
    name = "LockID"
    type = "S"
  }
  tags = {
    Name = "Terraform State Lock Table"
  }
}


resource "aws_s3_bucket_policy" "s3-japp-bc" {
  bucket = "s3-javaapp-rafaelrojas7752"
  
  policy = <<POLICY
{
    "Id": "Policy1563402733459",
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "Stmt1563401284635",
            "Action": "s3:*",
            "Effect": "Allow",
            "Resource": "arn:aws:s3:::s3-javaapp-rafaelrojas7752/*",
            "Principal": {
                "AWS": [
                    "arn:aws:iam::938635207917:user/terradmin"
                ]
            }
        }
    ]
}
POLICY
  depends_on = ["aws_s3_bucket.s3-javaapp-rafaelrojas7752"]
}
