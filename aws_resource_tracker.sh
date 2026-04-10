#!/bin/bash

# Author: Rubeena
# Date: 11th Jan
# Version: V1 (draft)
# Purpose: This script will report the AWS resource usage

# Enable debug mode
set -x

# Resources to track:
# 1. AWS S3
# 2. AWS EC2
# 3. AWS Lambda
#  4. AWS IAM Users



# Output file
OUTPUT_FILE="resource_tracker_$(date +%F).txt"

# Function to print section header
print_header() {
    echo "====================================" >> "$OUTPUT_FILE"
    echo "$1" >> "$OUTPUT_FILE"
    echo "====================================" >> "$OUTPUT_FILE"
}

# 1. List S3 buckets
print_header "Listing S3 Buckets"
echo "Print list of S3 buckets:" >> "$OUTPUT_FILE"
aws s3 ls >> "$OUTPUT_FILE"


# 2. List EC2 instances
print_header "Listing EC2 Instances"

echo "Print list of EC2 instances:" >> "$OUTPUT"

aws ec2 describe-instances >> "$OUTPUT_FILE"
#echo '{"Reservations":[...]}' | grep -o '"InstanceId": "[^"]*"' | cut -d'"' -f4

echo '{"Reservations":[...]}' | python3 -c 'import sys, json; print(json.load(sys.stdin)["Reservations"][0]["Instances"][0]["InstanceId"])'

# 3. List Lambda functions
print_header "Listing Lambda Functions"
echo "Print list of Lambda functions:" >> "$OUTPUT_FILE"
aws lambda list-functions >> "$OUTPUT_FILE"

# 4. List IAM users
print_header "Listing IAM Users"
echo "Print list of IAM users:" >> "$OUTPUT_FILE"
aws iam list-users >> "$OUTPUT_FILE"


set +x
echo "Resource tracking completed. Report saved to $OUTPUT_FILE"

