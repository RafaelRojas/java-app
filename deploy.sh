#!/bin/bash
##A bash script to deploy java-app env

WORKING_DIR=$(pwd)
TIMESTAMP=$(date "+%Y-%m-%d_%H:%M:%S")
LOGFILE="${WORKING_DIR}/scriptLog_${TIMESTAMP}"



##Create Images ###

echo "creatin app-server image-----------------------------------"  2>&1 | tee $LOGFILE  
cd $WORKING_DIR/images/app-server
sh build.sh 2>&1 | tee $LOGFILE

cd ..
echo "creatin ci-server image-----------------------------------"  2>&1 | tee $LOGFILE  
cd $WORKING_DIR/images/ci-server
sh build.sh 2>&1 | tee $LOGFILE

