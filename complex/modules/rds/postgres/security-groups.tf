resource "aws_security_group" "security_group_rds" {
  name_prefix = "${var.cluster_identifier}-rds"
  vpc_id      = var.vpc_id
  tags        = var.tags
}

resource "aws_security_group_rule" "allow_ingress_communicate_rds" {
  description              = "Allow aws resources to communicate with postgres database"
  for_each                 = var.allow_security_group_ids
  from_port                = var.allowed_port
  to_port                  = var.allowed_port
  protocol                 = "tcp"
  security_group_id        = aws_security_group.security_group_rds.id
  source_security_group_id = each.value
  type                     = "ingress"
}
