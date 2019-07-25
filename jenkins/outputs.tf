output "jenkins_private_key" {
  value = "tls_private_key.jenkins_key.private_key_pem"
}

output "jenkins_public_key" {
  value = "tls_private_key.jenkins_key.public_key_pem"
}

