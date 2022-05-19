variable "cluster_name" {
  type        = string
  description = "Elasticache cluster name."
}

variable "instance_type" {
  type        = string
  description = "Instance type for cluster"
}

variable "elasticache_subnets" {
  type        = list(string)
  description = "Elasticache subnets for use."
}
