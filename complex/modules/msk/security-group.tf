resource "aws_security_group" "sg" {
  vpc_id = var.vpc_id
}

resource "aws_security_group_rule" "allow_security_groups" {
  for_each                 = toset(var.allowed_security_groups)
  description              = "Allow specific security groups to access MSK cluster"
  from_port                = 9094
  to_port                  = 9094
  protocol                 = "tcp"
  security_group_id        = aws_security_group.sg.id
  source_security_group_id = each.key
  type                     = "ingress"
}
