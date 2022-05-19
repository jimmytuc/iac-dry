variable "backup_retention_period" {
  description = "The number of days to retain backups for."
  type        = number
  default     = 1
}

variable "cluster_identifier" {
  description = "The name/identifier for the cluster."
  type        = string
}

variable "copy_tags_to_snapshot" {
  description = "Should tags be copied to snapshots?"
  type        = bool
  default     = false
}

variable "database_name" {
  description = "Name for an automatically created database"
  type        = string
}

variable "db_subnet_group_name" {
  description = "A DB subnet group to be used for the cluster"
  type        = string
}

variable "db_security_groups" {
  description = "List of security group to be used to allow the communication to the database"
  type        = list(string)
  default     = []
}

variable "deletion_protection" {
  description = "Prevent deletion of the db cluster"
  type        = bool
  default     = false
}

variable "engine" {
  description = "DB engine type"
  type        = string
  default     = "aurora"
}

variable "engine_version" {
  description = "DB engine version"
  type        = string
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

variable "preferred_backup_window" {
  description = "Preferred backup window for the cluster"
  type        = string
  default     = "03:00-06:00"
}

variable "preferred_maintenance_window" {
  description = "Preferred maintenance window for the cluster"
  type        = string
  default     = "wed:04:00-wed04:30"
}

variable "skip_final_snapshot" {
  description = "Skip final snapshot for cluster on deletion"
  type        = bool
  default     = false
}

variable "tags" {
  description = "A mapping of tags to assign to the cluster"
  type        = map(string)
  default     = {}
}

variable "availability_zones" {
  description = "Availability zones"
  default     = ["us-east-2a"]
  type        = set(string)
}

variable "instance_class" {
  type    = string
  default = "db.t3.medium"
}

variable "vpc_id" {
  type = string
  description = "Specify the VPC ID which the RDS should belong to"
}

variable "environment" {
  type = string
  description = "Specify the environment"
}

variable "allow_security_group_ids" {
  type = set(string)
  description = "Specify the allowed security group id"
  default = []
}
