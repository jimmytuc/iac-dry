resource "aws_db_parameter_group" "rds_postgres_pg" {
  name        = var.cluster_identifier
  family      = var.parameter_group_family
  description = "RDS parameters group"
  parameter {
    name  = "log_min_duration_statement"
    value = "-1"
    apply_method = "pending-reboot"
  }

  parameter {
    name  = "rds.logical_replication"
    value = "1"
    apply_method = "pending-reboot"
  }

  parameter {
    name  = "log_replication_commands"
    value = "1"
    apply_method = "pending-reboot"
  }

  parameter {
    name  = "log_statement"
    value = "all"
    apply_method = "pending-reboot"
  }

  lifecycle {
    create_before_destroy = true
  }

  tags = var.tags
}

resource "aws_db_instance" "rds_postgres" {
  identifier            = var.cluster_identifier
  allocated_storage     = var.allocated_storage
  max_allocated_storage = var.max_allocated_storage
  storage_type          = var.storage_type
  storage_encrypted     = true
  engine                = "postgres"
  engine_version        = var.engine_version
  instance_class        = var.instance_class
  db_name               = var.master_dbname
  username              = var.master_username
  password              = var.master_password
  port                  = var.allowed_port
  vpc_security_group_ids  = [aws_security_group.security_group_rds.id]
  db_subnet_group_name    = var.db_subnet_group_name # aws_db_subnet_group.main.name
  availability_zone       = var.availability_zone
  multi_az                = false
  publicly_accessible     = false # strictly prevent in production env
  allow_major_version_upgrade = true
  parameter_group_name    = aws_db_parameter_group.rds_postgres_pg.name
  maintenance_window      = var.maintenance_window
  backup_window           = var.backup_window
  backup_retention_period = var.backup_retention_period
  skip_final_snapshot     = var.skip_final_snapshot
  apply_immediately       = var.apply_immediately
  copy_tags_to_snapshot   = var.copy_tags_to_snapshot
  deletion_protection     = var.environment == "production" ? true : false
  lifecycle {
    ignore_changes = [
      latest_restorable_time,
      availability_zone,
      password
    ]
  }
  tags = var.tags
}
