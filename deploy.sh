#!/bin/bash
##A bash script to deploy java-app env

export AWS_ACCESS_KEY_ID=AKIA5VCYEUTWZ2OPOKL6
export AWS_SECRET_ACCESS_KEY=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
export AWS_REGION=us-east-2

WORKING_DIR=$(pwd)
TIMESTAMP=$(date "+%Y-%m-%d_%H%M%S")
LOGFILE="${WORKING_DIR}/logs/scriptLog_${TIMESTAMP}"


BuildImages() {
  #Create Images ###
  BUILDLOG="${WORKING_DIR}/logs/buildLog_${TIMESTAMP}"
  echo "creating app-server image-----------------------------------"  2>&1 | tee $LOGFILE  
  cd $WORKING_DIR/images/app-server
  packer build packer.json  | tee $BUILDLOG
  cd  $WORKING_DIR

  echo "creating ci-server image-----------------------------------"  2>&1 | tee $LOGFILE  
  cd $WORKING_DIR/images/ci-server
  packer build packer.json | tee $BUILDLOG
  cd  $WORKING_DIR
}

DeployNetwork() {
  echo "Deploying network configurations=============================="
  cd  $WORKING_DIR/network
  NETWORKLOG="${WORKING_DIR}/logs/buildNetLog_${TIMESTAMP}"
  terraform apply -auto-approve | tee $NETWORKLOG
  cd  $WORKING_DIR
}


DeployBackend() {
  echo "Deploying backend configurations=============================="
  cd  $WORKING_DIR/backend
  BACKENDLOG="${WORKING_DIR}/logs/buildNetLog_${TIMESTAMP}"
  terraform apply -auto-approve | tee $BACKENDLOG
  cd  $WORKING_DIR
 }

# main function, can't live without it
main() {
  #BuildImages()
  DeployBackend
  DeployNetwork    
}
 




# although there are no parameters passed in this script, i still pass $* to main, as a habit
#main $*
# after Uri's comment, I'm fixing the following and calling "$@" instead
main "$@"
