terraform {
  required_version = "= 0.15.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "= 3.7.0"
    }
  }
}

resource "aws_db_instance" "postgres" {
  engine         = "postgres"
  engine_version = "13"

  name     = var.name
  username = var.master_username
  password = var.master_password

  instance_class    = var.instance_class
  allocated_storage = var.allocated_storage
  storage_type      = var.storage_type

  skip_final_snapshot = true
}
