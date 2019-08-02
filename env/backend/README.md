# AWS S3 backend module for Java App


terraform backend configuration for Java App. Consider the [minimum IAM Access for terrafom user](https://github.com/ozbillwang/terraform-best-practices#minimum-aws-permissions-necessary-for-a-terraform-run) 

After loading this backend don't forget to export environment variable of AWS_PROFILE with the profile with the specific permissions to write/read this bucket. Ex:
 
    export AWS_PROFILE=terraform-user

**DO NOT USE PUBLIC ACCESS BUCKET POLICY**
