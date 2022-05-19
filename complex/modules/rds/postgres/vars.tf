variable "environment" {
  default = "staging"
}
variable "vpc_id" {
  description = "Set the VPC for security group"
  type = string
}
variable "identifier_prefix" {
  description = "Identifier prefix for the RDS instance"
  type        = string
  default     = "app-"
}
variable "master_dbname" {
  description = "Specify the database name"
  type = string
}
variable "master_password" {
  description = "Master password for cluster"
  type        = string
}
variable "master_username" {
  description = "Master username for cluster"
  type        = string
  default     = "admin"
}
variable "cluster_identifier" {
  description = "The name of the postgres database to create on the DB instance"
  type        = string
}
variable "allocated_storage" {
  description = "Allocate storage"
  type        = number
  default     = 10
}
variable "max_allocated_storage" {
  description = "Max allocate storage"
  type        = number
  default     = 30
}
variable "storage_type" {
  description = "Storage type (e.g. gp2, io1)"
  type        = string
  default     = "gp2"
}
variable "instance_class" {
  description = "Instance class"
  default = "db.t3.medium"
}
variable "allowed_port" {
  description = "The target port which is allowing for connecting to the RDS"
  type = number
  default = 5432 # postgres
}
variable "allow_security_group_ids" {
  type = set(string)
  description = "Specify the allowed security group id"
  default = []
}
# backup options
variable "maintenance_window" {
  description = "Maintenance window"
  type        = string
  default     = "sun:04:32-sun:05:02"
}
variable "backup_window" {
  description = "Backup window"
  type        = string
  default     = "03:29-03:59"
}
variable "backup_retention_period" {
  description = "Backup retention period in days"
  type        = number
  default     = 14
}
variable "skip_final_snapshot" {
  description = "Skip final snapshot"
  type        = bool
  default     = true
}
variable "engine_version" {
  type = string
  default = "12.8"
}
variable "availability_zone" {
  type = string
  default = "ap-southeast-1a"
}
variable "copy_tags_to_snapshot" {
  description = "Copy tags to snapshots"
  type        = bool
  default     = true
}
# parameters group
variable "parameter_group_family" {
  description = "The family of the DB parameter group"
  type        = string
  default     = "postgres12"
}
variable "tags" {
  description = "A mapping of tags to assign to the cluster"
  type = map(string)
  default     = {}
}
variable "apply_immediately" {
  description = "Apply immediately, do not set this to true for production"
  type        = bool
  default     = false
}
variable "enabled_cloudwatch_logs_exports" {
  default     = true
  type        = bool
  description = "Indicates that postgresql logs will be configured to be sent automatically to Cloudwatch"
}
variable "db_subnet_group_name" {
  description = "Specify db subnet group from VPC module"
  default = null
}
