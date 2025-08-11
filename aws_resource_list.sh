#!/bin/bash
######################################################
# Author : Rubeena Shaik
# Date Modified : 11-08-2025

# Script to automate the process of listing all the resources in an AWS account
# Below are the services that are supported by this script:
# 1. EC2
# 2. RDS
# 3. S3
# 4. CloudFront
# 5. VPC
# 6. IAM
# 7. Route53
# 8. CloudWatch
# 9. CloudFormation
# 10. Lambda
# 11. SNS
# 12. SQS
# 13. DynamoDB
# 14. VPC
# 15. EBS

# The script will prompt the user to enter the AWS region and the service for which the resources need to be listed.
#
# Usage: ./aws_resource_list.sh  <aws_region> <aws_service>
# Example: ./aws_resource_list.sh us-east-1 ec2
######################################################

#Check if the correct number of arguments is provided
if [ "$#" -ne 2 ]; then
    echo "Usage: $0 <aws_region> <aws_service>"
    echo "Example: $0 us-east-1 ec2"
    exit 1
fi  

# Assign the arguments to variables and convert the service to lowercase
aws_region=$1
aws_service=$2

#check if the AWS CLI is installed
if ! command -v aws &> /dev/null; then
    echo "AWS CLI is not installed. Please install it and try again."
    exit 1
fi      

#Check if the AWS CLI is configured
if ! aws sts get-caller-identity &> /dev/null; then
    echo "AWS CLI is not configured. Please configure it using 'aws configure' and try again."
    exit 1
fi

#Check if the provided AWS region is valid
aws_region=$1
if ! aws ec2 describe-regions --region "$aws_region" &> /dev/null; then
    echo "Invalid AWS region: $aws_region"
    exit 1
fi              

#Check if the provided AWS service is valid
aws_service=$2
valid_services=("ec2" "rds" "s3" "cloudfront" "vpc" "iam" "route53" "cloudwatch" "cloudformation" "lambda" "sns" "sqs" "dynamodb" "ebs")
if [[ ! "${valid_services[@]}" =~ "${aws_service}" ]]; then
    echo "Invalid AWS service: $aws_service"
    echo "Valid services are: ${valid_services[*]}"
    exit 1
fi              

# List resources based on the provided service
case $aws_service in
    ec2)
        echo "Listing EC2 instances in region $aws_region..."
        aws ec2 describe-instances --region "$aws_region" --query "Reservations[*].Instances[*].[InstanceId,State.Name,InstanceType,PublicIpAddress,PrivateIpAddress]"
        ;;
    rds)
        echo "Listing RDS instances in region $aws_region..."
        aws rds describe-db-instances --region "$aws_region" --query "DBInstances[*].[DBInstanceIdentifier,DBInstanceStatus,Engine,Endpoint.Address]"
        ;;
    s3)
        echo "Listing S3 buckets in region $aws_region..."
        aws s3api list-buckets --query "Buckets[*].Name"
        ;;
    cloudfront)
        echo "Listing CloudFront distributions in region $aws_region..."
        aws cloudfront list-distributions --query "DistributionList.Items[*].[Id,Status,DomainName]"
        ;;
    vpc)
        echo "Listing VPCs in region $aws_region..."
        aws ec2 describe-vpcs --region "$aws_region" --query "Vpcs[*].[VpcId,State,CidrBlock]"
        ;;
    iam)
        echo "Listing IAM users in region $aws_region..."
        aws iam list-users --query "Users[*].[UserName,CreateDate,Arn]"
        ;;
    route53)
        echo "Listing Route 53 hosted zones in region $aws_region..."
        aws route53 list-hosted-zones --query "HostedZones[*].[Id,Name,Config.PrivateZone]"
        ;;
    cloudwatch)
        echo "Listing CloudWatch log groups in region $aws_region..."
        aws logs describe-log-groups --region "$aws_region" --query "logGroups[*].[logGroupName,creationTime]"
        ;;
    cloudformation)
        echo "Listing CloudFormation stacks in region $aws_region..."
        aws cloudformation describe-stacks --region "$aws_region" --query "Stacks[*].[StackName,StackStatus,CreationTime]"
        ;;
    lambda)
        echo "Listing Lambda functions in region $aws_region..."
        aws lambda list-functions --region "$aws_region" --query "Functions[*].[FunctionName,Runtime,LastModified]"
        ;;
    sns)
        echo "Listing SNS topics in region $aws_region..."
        aws sns list-topics --region "$aws_region" --query "Topics[*].Topic Arn"
        ;;
    sqs)
        echo "Listing SQS queues in region $aws_region..."
        aws sqs list-queues --region "$aws_region" --query "QueueUrls[*].[QueueUrl]"
        ;;
    dynamodb)
        echo "Listing DynamoDB tables in region $aws_region..."
        aws dynamodb list-tables --region "$aws_region" --query "TableNames[*].[TableName]"
        ;;
    ebs)
        echo "Listing EBS volumes in region $aws_region..."
        aws ec2 describe-volumes --region "$aws_region" --query "Volumes[*].[VolumeId,State,Size,AvailabilityZone]"
        ;;
    *)
        echo "Invalid service specified. Please choose from: ${valid_services[*]}"                         
        exit 1
        ;;
esac        

echo "Resource listing completed for service: $aws_service in region: $aws_region"
exit 0
