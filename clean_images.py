#!/usr/bin/python3
'''
The most simple Boto3 Script to delete the Packer created Snapshots and AMIs
WARNING: This script does not filter images or AMIs, it deletes ALL self owned objects.

'''
import boto3, sys
boto3.setup_default_session(profile_name = 'terraform-user')
ec2 = boto3.client('ec2', 'us-east-2')
images = ec2.describe_images(Owners=['self'])
for image in images['Images']:
    ami_id = image['ImageId']
    ami_description = image['Description']
    print("Deleting AMI ID: " + ami_id + ": " + ami_description)
    try:
        ec2.deregister_image(ImageId=ami_id)
    except:
       print('Cannot delete '  + ami_id)   

snaps = ec2.describe_snapshots(OwnerIds=['self'])
for snap in snaps['Snapshots']:
    snapshot_id = snap['SnapshotId']
    print("Deleting Snapshot ID: " + snapshot_id)
    try:
        ec2.delete_snapshot(SnapshotId=snapshot_id)
    except:
       print('Cannot delete '  + snapshot_id)
