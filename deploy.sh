#!/bin/bash
##A bash script to deploy java-app env

export AWS_ACCESS_KEY=AKIA5VCYEUTWS5TMLOIS 
export AWS_SECRET_KEY=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 
export AWS_REGION=us-east-2

WORKING_DIR=$(pwd)
TIMESTAMP=$(date "+%Y-%m-%d_%H:%M:%S")
LOGFILE="${WORKING_DIR}/scriptLog_${TIMESTAMP}"



#Create Images ###

#echo "creatin app-server image-----------------------------------"  2>&1 | tee $LOGFILE  
#cd $WORKING_DIR/images/app-server
#packer build packer.json

#cd ..
#echo "creatin ci-server image-----------------------------------"  2>&1 | tee $LOGFILE  
#cd $WORKING_DIR/images/ci-server
#packer build packer.json



