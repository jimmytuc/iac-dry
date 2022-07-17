variable "name" {
  type = string
  description = "Network Security Group Name."
}

variable "resource_group_name" {
  type = string
  description = "Resource group name."
}

variable "resource_group_location" {
  type = string
  description = "Resource group location."
}

variable "rules" {
  type = map(object({
    name = string
    priority = number
    direction = string
    access = string
    protocol = string
    source_port_range = string
    destination_port_range = string
    source_address_prefix = string
    destination_address_prefix = string
  }))
  description = "List of defined rules for Network Security Group"
}

variable "tags" {
  type = map(string)
  default = {
    Environment = "dev"
    CreatedBy   = "terraform"
  }
}
