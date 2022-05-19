variable "bucket_name" {
  description = "Name for the S3 bucket."
  type        = string
}
variable "tags" {
  type = map(string)
  description = "Tagging the s3 resource"
  default = {
    Application = "<app_name>-s3"
    Environment = "dev"
  }
}
