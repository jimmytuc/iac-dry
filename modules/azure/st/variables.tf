variable "storage_account_name" {
  type        = string
  description = "Required Input - The name for the backend storage account that will home the backend and primary state blob containers. (Unique all lowercase)"
}

variable "resource_group_name" {
  type = string
  description = "Resource group name."
}

variable "resource_group_location" {
  type = string
  description = "Resource group location."
}

variable "sa_access_tier" {
  type        = string
  default     = "Hot"
  description = "Optional Input - The access tier of the backend storage account. (accepted values: Cool, Hot)"
}

variable "sa_account_kind" {
  type        = string
  default     = "BlobStorage"
  description = "Optional Input - Defines the Kind of account. (accepted values: BlobStorage, BlockBlobStorage, FileStorage, Storage, StorageV2)"
}

variable "sa_account_tier" {
  type        = string
  default     = "Standard"
  description = "Optional Input - Defines the Tier to use for this storage account. (accepted values: Standard, Premium. For FileStorage accounts only Premium is valid.)"
}

variable "sa_account_repl" {
  type        = string
  default     = "LRS"
  description = "Optional Input - Defines the type of replication to use for this storage account. (accepted values: LRS, GRS, RAGRS, ZRS)"
}

variable "sa_account_https" {
  type        = bool
  default     = true
  description = "Optional Input - Boolean flag which forces HTTPS if enabled. (accepted values: true, false)"
}

variable "tags" {
  type = map(string)
  default = {
    Environment = "dev"
    CreatedBy   = "terraform"
  }
}
