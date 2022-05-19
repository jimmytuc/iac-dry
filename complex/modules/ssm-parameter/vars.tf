variable "aws_ssm" {
  type = string
}

variable "environment" {
  type = string
  default = "dev"
}

variable "app_name" {
  type = string
}

variable "tags" {
  type = map(any)
  default = {}
}

variable "password_length" {
  type = number
  default = 24
}

variable "allow_special_chars" {
  type = bool
  default = false
}