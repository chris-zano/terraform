variable "vpc_cidr" {
  description = "CIDR block for the VPC (10.0.0.0/16 provides 65,536 IP addresses)"
  type        = string
}

variable "public_subnet_cidrs" {
  description = "CIDR blocks for public subnets across multiple AZs"
  type        = list(string)
}

variable "private_subnet_cidrs" {
  description = "CIDR blocks for private subnets across multiple AZs"
  type        = list(string)
}

variable "availability_zones" {
  description = "AWS availability zones in eu-west-1 region"
  type        = list(string)
}

variable "environment" {
  description = "Environment name for resource tagging and identification (dev/staging/prod)"
  type        = string
}

variable "ami_id" {
  description = "Ubuntu 24.04 LTS AMI ID for eu-west-1 region"
  type        = string
}

variable "instance_type" {
  description = "EC2 instance type (t3.micro is free tier eligible)"
  type        = string
}

variable "key_name" {
  description = "Name of the SSH key pair for EC2 instance access"
  type        = string
}
