# AWS Network  module for Java App

Network backend configuration for Java App. This module creates:

* A java-app VPC.
* An Internet Gateway.
* Public & Private routing tables
* Subnets for such routing tables

All those resources names get out on an output.tf file which gets loaded on the AppServer, Jenkins and Database environment creation.
