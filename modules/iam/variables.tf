variable "eks_role_name" {
  description = "IAM role name for the EKS cluster"
  type        = string
}

variable "node_group_role_name" {
  description = "IAM role name for the EKS worker nodes"
  type        = string
}

