resource "aws_rds_cluster" "default" {
  cluster_identifier      = var.cluster_identifier
  engine                  = var.engine
  engine_version          = var.engine_version
  availability_zones      = var.availability_zones
  database_name           = var.database_name
  master_username         = var.master_username
  master_password         = var.master_password
  backup_retention_period = var.backup_retention_period
  preferred_backup_window = var.preferred_backup_window
  skip_final_snapshot     = var.skip_final_snapshot
  db_subnet_group_name    = var.db_subnet_group_name
  vpc_security_group_ids  = var.db_security_groups
  #final_snapshot_identifier = "${var.cluster_identifier}-${var.database_name}"
  tags = var.tags
}

resource "aws_rds_cluster_instance" "cluster_instances" {
  count                = 2
  identifier           = "${var.cluster_identifier}-${count.index}"
  cluster_identifier   = aws_rds_cluster.default.id
  instance_class       = var.instance_class
  engine               = aws_rds_cluster.default.engine
  engine_version       = aws_rds_cluster.default.engine_version
  db_subnet_group_name = var.db_subnet_group_name
  tags                 = var.tags
}
