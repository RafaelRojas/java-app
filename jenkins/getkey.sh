#!/bin/bash
output=$(cat terraform.tfstate |   grep private_key_pem  | grep -v value | cut -d ":" -f 2)
echo -e $output | sed  -e 's/"//g'  | sed  -e 's/,//g' | grep -v '^$' >> jenkins_private_key.pem 
#mv dev_private_key.pem ~/aws-scripts/keys/
#chmod 0400  ~/aws-scripts/keys/dev_private_key.pem
