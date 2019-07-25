output "java-app_vpc" {
  value = aws_vpc.java-app_vpc.id
}

output "java-app_ig" {
  value = aws_internet_gateway.java-app_ig.id
}

output "java-app_public_rt" {
  value = aws_route_table.java-app_public_rt.id
}

output "java-app-default_route_table" {
  value = aws_default_route_table.java-app_private_rt.id
}

output "java-app_private_subnet" {
  value = aws_subnet.java-app_private_subnet.id
}

output "java-app_public_subnet" {
  value = aws_subnet.java-app_public_subnet.id
}

output "java-app_rds_subnet1" {
  value = aws_subnet.java-app_rds_subnet1.id
}

output "java-app_rds_subnet2" {
  value = aws_subnet.java-app_rds_subnet2.id
}

output "java-app_rds_sng" {
  value = aws_db_subnet_group.java-app_rds_sng.id
}

