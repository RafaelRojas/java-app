#!/bin/bash
set -x

packer build -var "aws_access_key=$aws_access_key" -var "aws_secret_key=$aws_secret_key"  -var "aws_region=$aws_region" packer.json
