variable "env" {
  type        = string
  description = "Environment"
}

variable "admin_users" {
  type        = list(string)
  description = "List of Kubernetes admins."
}

variable "developer_users" {
  type        = list(string)
  description = "List of Kubernetes developers."
}

variable "vpc_id" {
  type        = string
  description = "VPC Id."
}

variable "cluster_name" {
  type        = string
  description = "Name of the EKS Cluster."
}

variable "kubernetes_version" {
  type        = string
  description = "The kubernetes engine version"
  default     = "1.21"
}

variable "public_subnets" {
  type        = list(string)
  description = "Public subnets"
}

variable "private_subnets" {
  type        = list(string)
  description = "Private subnets"
}

variable "name_prefix" {
  type        = string
  description = "Prefix to be used on each infrastructure object Name created in AWS."
}

variable "asg_instance_types" {
  type        = list(string)
  description = "List of EC2 instance machine types to be used in EKS."
}

variable "autoscaling_minimum_size_by_az" {
  type        = number
  description = "Minimum number of EC2 instances to autoscale the EKS cluster on each AZ."
}

variable "autoscaling_maximum_size_by_az" {
  type        = number
  description = "Maximum number of EC2 instances to autoscale the EKS cluster on each AZ."
}

variable "autoscaling_average_cpu" {
  type        = number
  description = "Average CPU threshold to autoscale EKS EC2 instances."
}

variable "spot_termination_handler_chart_name" {
  type        = string
  description = "EKS Spot termination handler Helm chart name."
}

variable "spot_termination_handler_chart_repo" {
  type        = string
  description = "EKS Spot termination handler Helm repository name."
}

variable "spot_termination_handler_chart_version" {
  type        = string
  description = "EKS Spot termination handler Helm chart version."
}

variable "spot_termination_handler_chart_namespace" {
  type        = string
  description = "Kubernetes namespace to deploy EKS Spot termination handler Helm chart."
}

# variable "kubernetes_dashboard_chart_name" {
#   type        = string
#   description = "Kubernetes dashboard Helm chart name."
# }
#
# variable "kubernetes_dashboard_chart_repo" {
#   type        = string
#   description = "Kubernetes dashboard Helm repository name."
# }
#
# variable "kubernetes_dashboard_chart_version" {
#   type        = string
#   description = "Kubernetes dashboard Helm chart version."
# }
#
# variable "kubernetes_dashboard_chart_namespace" {
#   type        = string
#   description = "Kubernetes namespace to deploy Kubernetes dashboard."
# }
