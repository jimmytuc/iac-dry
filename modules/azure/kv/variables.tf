variable "name" {
  description = "Specify KeyVault name"
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

variable "soft_delete_retention_days" {
  description = "The number of days that items should be retained for once soft-deleted. The value can be range 7 - 90 (days)."
  type = number
  default = 7
}

variable "enabled_for_disk_encryption" {
  description = "Specify whether Azure Disk Encryption is permitted to retrieve secrets from the vault and unwrap keys"
  type = bool
  default = true
}

variable "purge_protection_enabled" {
  description = " Is Purge Protection enabled for this Key Vault?"
  type = bool
  default = false
}

variable "secret_permissions" {
  description = "List of secret permissions."
  type = list(string)
  default = [
    "Get",
    "Backup",
    "Delete",
    "List",
    "Purge",
    "Recover",
    "Restore",
    "Set",
  ]
}

variable "storage_permissions" {
  description = "List of storage permissions."
  type = list(string)
  default = [
    "Get",
  ]
}

variable "key_permissions" {
  description = "List of key permissions"
  type = list(string)
  default = [
    "Get",
  ]
}

variable "tags" {
  type = map(string)
  default = {
    Environment = "dev"
    CreatedBy   = "terraform"
  }
}
