variable "location" {
  description = "Region/Location where the creating resource belongs to."
  type = string
  default = "Australia East"
}

variable "location_short" {
  description = "Region/Location where the creating resource belongs to in short codes."
  type = string
  default = "australia-east1"
}

variable "environment" {
  description = "The environment for creating the resource."
  type = string
  default = "dev"
}

variable "service_name" {
  description = "What is the infrastructure about"
  type = string
}
