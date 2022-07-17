variable "vnet_name" {
  type = string
}

variable "subnet_name" {
  type = string
}

variable "resource_group_name" {
  type = string
  description = "Resource group name."
}

variable "resource_group_location" {
  type = string
  description = "Resource group location."
}

variable "cidr" {
  type = list(string)
  default = []
}

variable "subnet_cidr" {
  type = list(string)
  default = []
}

variable "tags" {
  type = map(string)
  default = {
    Environment = "dev"
    CreatedBy   = "terraform"
  }
}
