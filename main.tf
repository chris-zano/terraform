module "vpc" {
  source = "./modules/vpc"

  vpc_cidr             = var.vpc_cidr
  public_subnet_cidrs  = var.public_subnet_cidrs
  private_subnet_cidrs = var.private_subnet_cidrs
  availability_zones   = var.availability_zones
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Environment = var.environment
    Project     = "Terraform Demo Project 1"
  }
}

module "ec2" {
  source = "./modules/ec2"

  ami_id             = var.ami_id
  instance_type      = var.instance_type
  key_name           = var.key_name
  subnet_id          = module.vpc.public_subnet_ids[0]
  security_group_ids = [module.security_group.sg_id]
  tags = {
    Environment = var.environment
    Role        = "DockerHost"
  }
}

module "security_group" {
  source      = "./modules/security_group"
  name        = "ec2-sg"
  vpc_id      = module.vpc.vpc_id
  description = "Security group for EC2 instance"

  ingress_rules = [
    {
      from_port   = 22
      to_port     = 22
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    },
    {
      from_port   = 80
      to_port     = 80
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
  ]

  egress_rules = [
    {
      from_port   = 0
      to_port     = 0
      protocol    = "-1"
      cidr_blocks = ["0.0.0.0/0"]
    }
  ]

  tags = {
    Name        = "ec2-sg"
    Environment = var.environment
  }
}

module "iam" {
  source = "./modules/iam"

  eks_role_name        = "eks-cluster-role"
  node_group_role_name = "eks-node-group-role"
}

module "eks" {
  source = "./modules/eks"

  cluster_name             = "my-eks-cluster"
  vpc_id                   = module.vpc.vpc_id
  subnet_ids               = module.vpc.public_subnet_ids
  eks_role_arn             = module.iam.eks_role_arn
  node_group_name          = "my-node-group"
  node_group_instance_type = "t3.medium"
  node_group_role_arn      = module.iam.node_group_role_arn
}