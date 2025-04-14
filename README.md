# Terraform AWS Infrastructure Project

This project provides infrastructure as code (IaC) for deploying a complete AWS environment including VPC, EC2 instances, EKS cluster, and associated resources.

## Project Structure

```
terraform_project_1/
├── modules/
│   ├── ec2/
│   ├── eks/
│   ├── iam/
│   ├── security_group/
│   └── vpc/
├── scripts/
│   └── user_data.sh
├── jenkins/
│   └── Jenkinsfile
├── main.tf
├── variables.tf
├── outputs.tf
├── provider.tf
└── backend.tf
```

## Prerequisites

- Terraform >= 1.11.3
- AWS CLI configured with appropriate credentials
- Jenkins (for CI/CD pipeline)
- S3 bucket for Terraform state (specified in backend.tf)

## Modules

### VPC Module
- Creates a VPC with public and private subnets
- Configures Internet Gateway and routing tables
- Supports multiple availability zones

### EC2 Module
- Deploys EC2 instances with customizable configurations
- Includes user data script for Docker installation
- Supports multiple security groups

### Security Group Module
- Creates customizable security groups
- Supports dynamic ingress and egress rules
- Configurable per environment

### IAM Module
- Sets up IAM roles for EKS cluster
- Configures node group permissions
- Implements least privilege principle

### EKS Module
- Deploys managed Kubernetes cluster
- Configures worker node groups
- Sets up cluster security groups

## Configuration

### Required Variables
```hcl
vpc_cidr             = "10.0.0.0/16"
public_subnet_cidrs  = ["10.0.1.0/24", "10.0.2.0/24"]
private_subnet_cidrs = ["10.0.101.0/24", "10.0.102.0/24"]
availability_zones   = ["eu-west-1a", "eu-west-1b"]
environment         = "dev"
```

### Backend Configuration
The project uses an S3 backend for state management:
```hcl
terraform {
  backend "s3" {
    bucket  = "terraform-backend-bucket-niico"
    key     = "terraform/terraform.tfstate"
    region  = "eu-west-1"
    encrypt = true
  }
}
```

## Usage

1. Initialize Terraform:
```bash
terraform init
```

2. Review the execution plan:
```bash
terraform plan
```

3. Apply the configuration:
```bash
terraform apply
```

4. To destroy the infrastructure:
```bash
terraform destroy
```

## CI/CD Pipeline

The project includes a Jenkins pipeline configuration that:
- Installs required tools
- Initializes Terraform
- Validates configurations
- Plans and applies changes
- Outputs results

## Outputs

The deployment provides several useful outputs:
- VPC ID
- Public and Private Subnet IDs
- EC2 Instance ID and IP
- Security Group ID
- EKS Cluster Endpoint

## License

This project is proprietary and confidential.
