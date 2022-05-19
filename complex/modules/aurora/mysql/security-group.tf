resource "aws_security_group" "security_group_rds_mysql" {
  name_prefix = "${var.environment}-mysql-rds"
  vpc_id      = var.vpc_id
  tags        = var.tags
}

resource "aws_security_group_rule" "allow_communicate_mysql" {
  description              = "Allow the sg source to communicate with aurora mysql database"
  for_each                 = var.allow_security_group_ids
  from_port                = 3306
  to_port                  = 3306
  protocol                 = "tcp"
  security_group_id        = aws_security_group.security_group_rds_mysql.id
  source_security_group_id = each.value
  type                     = "ingress"
}
