variable "bucket_name" {
  description = "S3 bucket name"
}
variable "dynamo_lock_name" {
  description = "DynamoDB lock table name"
}
variable "bucket_enable_versioning" {
  description = "Enable the bucket versioning"
  default = false
}
variable "aws_region" {
  description = "AWS region."
  default = "us-east-1"
}
variable "tags" {
  description = "Specify tagging resources"
  default = {
    Application = "app-s3"
    Environment = "Production"
  }
}
