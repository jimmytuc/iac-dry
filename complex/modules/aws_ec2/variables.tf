variable "environment" {
  type = string
}

variable "name" {
  type = string
}

variable "image_name" {
  type = string
}

variable "owner_id" {
  type = string
}

variable "vpc_id" {
  type = string
}

variable "subnet_id" {
  type = string
}

variable "key_name" {
  type = string
}

variable "instance_type" {
  type = string
}

variable "spot_price" {
  type = string
}

variable "eip_enabled" {
  type    = bool
  default = false
}

variable "volume_size" {
  type    = number
  default = 50
}
