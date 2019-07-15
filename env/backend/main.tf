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
    prevent_destroy = true
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

#  policy = <<POLICY
#{
#  "Version": "2012-10-17",
#  "Statement": [
#    {
#      "Effect": "Allow",
#      "Action": "s3:ListBucket",
#      "Resource": "arn:aws:s3:::s3-javaapp-rafaelrojas7752"
#    },
#    {
#      "Effect": "Allow",
#      "Action": ["s3:GetObject", "s3:PutObject"],
#      "Resource": "arn:aws:s3:::s3-javaapp-rafaelrojas7752"
#    }
#  ]
#}
#POLICY
policy =<<EOF
{
  "Version": "2012-10-17",
  "Id": "RequireEncryption",
   "Statement": [
    {
      "Sid": "RequireEncryptedTransport",
      "Effect": "Deny",
      "Action": ["s3:*"],
      "Resource": ["arn:aws:s3:::s3-javaapp-rafaelrojas7752/*"],
      "Condition": {
        "Bool": {
          "aws:SecureTransport": "false"
        }
      },
      "Principal": "*"
    },
    {
      "Sid": "RequireEncryptedStorage",
      "Effect": "Deny",
      "Action": ["s3:PutObject"],
      "Resource": ["arn:aws:s3:::s3-javaapp-rafaelrojas7752/*"],
      "Condition": {
        "StringNotEquals": {
          "s3:x-amz-server-side-encryption": "AES256"
        }
      },
      "Principal": "*"
    }
  ]
}
EOF
}
