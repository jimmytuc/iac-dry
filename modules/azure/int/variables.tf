variable "name" {
  description = "Network Interface name."
}

variable "resource_group_name" {
  type = string
  description = "Resource group name."
}

variable "resource_group_location" {
  type = string
  description = "Resource group location."
}

variable "subnet_id" {
  type = string
  description = "Subnet ID."
}

variable "tags" {
  type = map(string)
  default = {
    Environment = "Staging"
    CreatedBy   = "Terraform"
  }
}
