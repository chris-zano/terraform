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
├── backend.tf
├── terraform.tfvars
└── terraform.tfbackend
```

## Prerequisites

- Terraform >= 1.11.3
- AWS CLI configured with appropriate credentials
- Jenkins (for CI/CD pipeline)
- S3 bucket for Terraform state

## Configuration Files

### Backend Configuration (terraform.tfbackend)
```hcl
bucket  = "********"
key     = "********
region  = "********"
encrypt = true
use_lockfile = true
```

### Variables Configuration (terraform.tfvars)
```hcl
vpc_cidr             = "10.0.0.0/16"
public_subnet_cidrs  = ["10.0.1.0/24", "10.0.2.0/24"]
private_subnet_cidrs = ["10.0.101.0/24", "10.0.102.0/24"]
availability_zones   = ["region1a", "region1b"]
environment         = "dev"
ami_id             = "ami-name"
instance_type      = "instance-type"
key_name           = "key-pair-name"
```

## Usage

1. Initialize Terraform with backend configuration:
```bash
terraform init -backend-config="terraform.tfbackend"
```

2. Review the execution plan:
```bash
terraform plan -var-file=terraform.tfvars
```

3. Apply the configuration:
```bash
terraform apply -var-file=terraform.tfvars
```

4. To destroy the infrastructure:
```bash
terraform destroy -var-file=terraform.tfvars
```

## CI/CD Pipeline

The project includes a Jenkins pipeline that:
- Installs required tools
- Initializes Terraform with backend configuration
- Validates configurations
- Plans and applies changes using tfvars
- Outputs results

## Outputs

The deployment provides:
- VPC ID
- Public and Private Subnet IDs
- EC2 Instance ID and IP
- Security Group ID
- EKS Cluster Endpoint

## Security Considerations

- All sensitive data should be stored in `.tfvars` files (not committed to version control)
- Backend configuration should be secured and encrypted
- Use of least privilege principle for IAM roles
- Security groups with minimal required access

## Best Practices

- Use separate tfvars files for different environments
- Regular state backup
- Code review before applying changes
- Maintain proper documentation
- Use consistent naming conventions

## License

This project is proprietary and confidential.
