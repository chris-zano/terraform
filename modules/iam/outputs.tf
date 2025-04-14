output "eks_role_arn" {
  description = "The ARN of the EKS cluster role"
  value       = aws_iam_role.eks_cluster_role.arn
}

output "node_group_role_arn" {
  description = "The ARN of the EKS worker node role"
  value       = aws_iam_role.eks_node_group_role.arn
}
