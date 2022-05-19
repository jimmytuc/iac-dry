data "aws_ami" "main" {
  most_recent = true

  filter {
    name   = "name"
    values = [var.image_name]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = [var.owner_id]
}

resource "aws_spot_instance_request" "main" {
  ami                    = data.aws_ami.main.id
  instance_type          = var.instance_type
  subnet_id              = var.subnet_id
  spot_price             = var.spot_price
  key_name               = var.key_name
  vpc_security_group_ids = [aws_security_group.main.id]

  root_block_device {
    volume_size = var.volume_size
  }

  tags = {
    Name = "${var.environment}-${var.name}"
  }
}
