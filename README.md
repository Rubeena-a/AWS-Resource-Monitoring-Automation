# AWS Resource Lister – Shell Scripting Project

## 📌 Project Overview
This project automates the process of listing **active AWS resources** for specific services in a given AWS region using a shell script.  
The project focuses on automating AWS resource management using shell scripting. The primary goal is to create a shell script that connects to AWS and lists active resources based on user-defined parameters. This automation aids in monitoring and managing cloud resources efficiently

The script:
- Connects to AWS using **AWS CLI**
- Accepts **two arguments**: `region` and `service`
- Lists **only active resources** for the specified AWS service
- Supports **only allowed services** defined in the script
- Implements **best practices** for shell scripting and security

---

## 🚦 How to Run This Script on an EC2 Instance (Ubuntu)

Follow these steps to use the script on an Ubuntu-based EC2 instance:

1. **Launch an EC2 Instance**
   - Use the AWS Console or CLI to launch an Ubuntu EC2 instance.
   - Ensure the instance has an IAM role with permissions to list AWS resources, or configure credentials manually.

2. **Connect to Your EC2 Instance**
   ```bash
   ssh -i <your-key.pem> ubuntu@<ec2-public-dns>
   ```

3. **Update the System (Optional but Recommended)**
   ```bash
   sudo apt update && sudo apt upgrade -y
   ```

4. **Install AWS CLI (if not already installed)**
   ```bash
   sudo apt install awscli -y
   aws --version
   ```

5. **Configure AWS CLI (if not using an IAM role)**
   ```bash
   aws configure
   ```
   - Enter your AWS Access Key, Secret Key, default region, and output format.

6. **Transfer the Script to the EC2 Instance**
   - You can use `scp` from your local machine:
     ```bash
     scp -i <your-key.pem> aws_resource_list.sh ubuntu@<ec2-public-dns>:~/
     ```
   - Or, create the script directly on the instance using a text editor like `nano` or `vim`.

7. **Make the Script Executable**
   ```bash
   chmod +x aws_resource_list.sh
   ```

8. **Run the Script**
   ```bash
   ./aws_resource_list.sh <aws_region> <aws_service>
   ```
   - Example:
     ```bash
     ./aws_resource_list.sh us-east-1 ec2
     ```

---

## 🛠 Supported AWS Services
By default, the script supports these services:

- `ec2` – List running EC2 instances  
- `s3` – List S3 buckets  
- `ebs` – List active EBS volumes  
- `rds` – List RDS instances  
- `dynamodb` – List DynamoDB tables  
- `sns` – List SNS topics  
- `lambda` – List Lambda functions  
- `vpc` – List VPCs  
- `efs` – List EFS file systems  
- `eks` – List EKS clusters  
- `cloudformation` – List CloudFormation stacks  
- `iam` – List IAM users and roles  
- `elb` – List Elastic Load Balancers  

*(You can add/remove services in the script as per your organization’s usage.)*

---

## 📋 Prerequisites
Before running the script, ensure you have:

1. **AWS CLI Installed**  
   [Installation Guide](https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html)  
   Check installation:  
   ```bash
   aws --version
   ```
2. **AWS credentials** with permissions to list resources for the desired services.

---

## 🚀 Usage

### 1. Make the Script Executable
- To grant all the access
```bash
chmod +x aws_resource_list.sh
```
- For specific Access (user, groups all the access, others with only execute access)
```bash
chmod 771 aws_resource_list.sh
```

### 2. Run the Script

```bash
./aws_resource_list.sh <aws_region> <aws_service>
```

- `<aws_region>`: The AWS region code (e.g., `us-east-1`, `eu-west-1`)
- `<aws_service>`: The AWS service to list (see supported services above)

#### Example

```bash
./aws_resource_list.sh us-east-1 ec2
```

This will list all EC2 instances in the `us-east-1` region.

---

## 📝 Example Outputs

**List S3 Buckets:**
```bash
./aws_resource_list.sh us-east-1 s3
```
_Output:_
```
Listing S3 buckets in region us-east-1...
[
    "my-bucket-1",
    "my-bucket-2"
]
Resource listing completed for service: s3 in region: us-east-1
```

**List Lambda Functions:**
```bash
./aws_resource_list.sh eu-west-1 lambda
```
_Output:_
```
Listing Lambda functions in region eu-west-1...
[
    [
        "my-function",
        "python3.8",
        "2025-08-11T12:34:56.000+0000"
    ]
]
Resource listing completed for service: lambda in region: eu-west-1
```

---

## ✅ Validation

The script performs several validation checks before listing AWS resources:

1. **Argument Validation**  
   - Ensures exactly two arguments are provided: `<aws_region>` and `<aws_service>`.
   - If not, it displays usage instructions and exits.

2. **AWS CLI Installation Check**  
   - Verifies if the AWS CLI is installed on your system.
   - If not found, it prompts you to install the AWS CLI and exits.

3. **AWS CLI Configuration Check**  
   - Checks if the AWS CLI is configured with valid credentials.
   - If not configured, it prompts you to run `aws configure` and exits.

4. **AWS Region Validation**  
   - Validates the provided AWS region.
   - If the region is invalid, it displays an error and exits.

5. **AWS Service Validation**  
   - Checks if the provided service is among the supported services.
   - If not, it lists the valid services and exits.

---

> _See the images below for sample validation outputs:_
>
> ![Argument Validation Output](/workspaces/shell-scripting-devops/images/Argument Validation Output.png)
> ![AWS CLI Not Installed Output](images//workspaces/shell-scripting-devops/images/AWS CLI Not Configured Output.png)
> ![AWS CLI Not Configured Output](images//workspaces/shell-scripting-devops/images/AWS CLI Not Installed Output.png)
> ![Invalid Region Output](images/validation-region.png)
> ![Invalid Service Output](images/validation-service.png)

---

## ⚠️ Notes

- The script checks for AWS CLI installation and configuration.
- Only valid AWS regions and supported services are accepted.
- Output is displayed in JSON format for easy parsing.
- You can add or remove supported services by editing the script.

---

## 👩‍💻 Author

Rubeena Shaik

---