#!/bin/bash
set -x

packer build -var "aws_access_key_id=AKIA5VCYEUTWZ2OPOKL6" -var "aws_secret_access_key=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"   -var "aws_region=us-east-2"  packer.json


