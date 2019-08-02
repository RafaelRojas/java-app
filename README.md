# Java-App AWS enviroment.

An AWS simple Java App enviroment based on 3 simple web balanced EC2 instances, one Jenkins build server and a MYSQL server. Written in terraform 0.12

Instances are created through an AppServer and a Jenkins golden Images generated with Packer + Ansible. Managing of instances and snapshots are done via py script with BOTO3.

We use an AWS S3 bucket as terraform backend only for workshop reasons. TODO: move backend to terraform.io or use consul.

Modularized and linked infrastructure as far as possible. ~~Followed~~ Following [Terraform best practices](https://github.com/ozbillwang/terraform-best-practices).

_______________________
<root@rafaelrojas.net> 
