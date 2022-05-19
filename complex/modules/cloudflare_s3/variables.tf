variable "cloudflare_email" {
  description = "The email associated with the account. This can also be specified with the CLOUDFLARE_EMAIL shell environment variable."
  type        = string
}

variable "cloudflare_api_key" {
  description = "The Cloudflare API key. This can also be specified with the CLOUDFLARE_API_KEY shell environment variable."
  type        = string
}

variable "aws_region" {
  type        = string
  default     = "us-east-2"
  description = "The AWS region to put the bucket into"
}

variable "domain" {
  type        = string
  description = "The domain name to use for the static files"
}

variable "bucket" {
  type        = string
  description = "The bucket name to use for the static files"
}

variable "cert_arn" {
  type = string
}
