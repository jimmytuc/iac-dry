variable "name" {
  description = "Cluster name"
  type        = string
}

variable "env" {
  description = "Environment"
  type        = string
}

variable "vpc_id" {
  description = "VPC ID to create MSK cluster."
  type        = string
}

variable "subnets" {
  description = "Subnets to use for the MSK cluster."
  type        = list(string)
}

variable "node_count" {
  type    = number
  default = 3
}

variable "tags" {
  type        = map(string)
  description = "Tagging the resources"
  default = {
    Application = "app"
    Environment = "dev"
  }
}

variable "allowed_security_groups" {
  type        = list(string)
  description = "List of allowed security group IDs"
  default     = []
}
