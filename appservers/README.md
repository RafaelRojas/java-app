# AWS AppServers module for Java APP

This module creates:

* A 2048 bits RSA default key for the instance. **This is the default SSH key used for instances outside the ones added by Ansible, it is stored on the .tfstate file as plain text. USE WITH CARE.**
* A java App launch configuration that uses a privately owned, not public Packer created java app golden image, using t2.micro as instance type, for aws free tier.
* An autoscaling group of min=1, max=3 desired=3 instances.
* A security group that allows port 22 (SSH), 80, (Nginx) and 8080 (Apache Tomcat).
