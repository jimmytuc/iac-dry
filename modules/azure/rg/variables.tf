variable "name" {
  type = string
  description = "Resource group name."
}

variable "location" {
  type = string
  description = "Resource group location."
}

variable "tags" {
  type = map(string)
  default = {
    Environment = "dev"
    CreatedBy   = "terraform"
  }
}
