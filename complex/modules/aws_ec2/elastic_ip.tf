resource "aws_eip" "main" {
  count    = var.eip_enabled ? 1 : 0
  instance = aws_spot_instance_request.main.spot_instance_id
  vpc      = true

  tags = {
    Name = "${var.environment}-${var.name}"
  }
}
