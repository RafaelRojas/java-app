###AWS S3 backend module for Java App###


# terraform backend configuration for  
# Java App. COnsider the minimum IAM Access for terrafom user taken from                 
#  https://github.com/ozbillwang/terraform-best-practices#minimum-aws-permissions-necessary-for-a-terraform-run 

# After loading this BACKED don't forget to export environment variable of AWS_PROFILE with the profile with the
# Sepecific permissions to write/read this bucket. Ex: 
#  export AWS_PROFILE=terraform-user

# DO NOT USE PUBLIC ACESS BUCKET
