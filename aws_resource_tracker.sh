#!/bin/bash

#########################
# Author: Devansh
# Date: 30th December
#
# Version: v1
#
# This script will report the AWS resource usage
########################

# AWS S3
# AWS EC2
# AWS Lambda
# AWS IAM Users

set -x

# List s3 buckets
echo "Print List of S3 Buckets"
aws s3 ls

# List EC2 instances
echo "Print List of EC2 Instances"
aws ec2 describe-instances | jq '.Reservation[].Instances[].InstanceId'

# List lambda
echo "Print List of lambda Instances"
aws lambda list-functions

# List IAM functions
echo "Print List of IAM Functions"
aws iam list-users
