output "java-app_vpc" {
  value = aws_vpc.java-app_vpc.id
}

output "java-app_private_subnet" {
  value = aws_subnet.java-app_private_subnet.id
}

output "java-app_public_subnet" {
  value = aws_subnet.java-app_public_subnet.id
}

output "java-app_rds_subnet1" {
  value = "aws_subnet.java-app_rds_subnet1.id"
}

output "java-app_rds_subnet2" {
  value = "aws_subnet.java-app_rds_subnet2.id"
}

output "java-app_rds_sng" {
  value = "aws_db_subnet_group.java-app_rds_sng.id"
}

