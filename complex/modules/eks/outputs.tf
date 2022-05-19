output "eks_host" {
  value = data.aws_eks_cluster.default.endpoint
}

output "eks_ca_certificate" {
  sensitive = true
  value = base64decode(data.aws_eks_cluster.default.certificate_authority.0.data)
}

output "eks_token" {
  sensitive = true
  value = data.aws_eks_cluster_auth.default.token
}

output "worker_security_group_id" {
  value = module.eks-cluster.node_security_group_id
}

output "cluster_security_group_id" {
  value = module.eks-cluster.cluster_primary_security_group_id
}
