terraform {
  required_version = ">= 0.15.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "= 3.7.0"
    }
  }
}

resource "aws_autoscaling_group" "cluster" {
  launch_configuration = aws_launch_configuration.cluster.id
  vpc_zone_identifier  = data.aws_subnet_ids.default.ids

  load_balancers    = [aws_elb.cluster.name]
  health_check_type = "ELB"

  min_size = var.min_size
  max_size = var.max_size

  tag {
    key                 = "Name"
    value               = var.name
    propagate_at_launch = true
  }
}

# ---------------------------------------------------------------------------------------------------------------------
# CREATE THE LAUNCH CONFIGURATION
# This defines what runs on each EC2 Instance in the ASG. To keep the example simple, we run a plain Ubuntu AMI and
# configure a User Data scripts that runs a dirt-simple "Hello, World" web server. In real-world usage, you'd want to
# package the web server code into a custom AMI (rather than shoving it into User Data) and pass in the ID of that AMI
# as a variable.
# ---------------------------------------------------------------------------------------------------------------------

resource "aws_launch_configuration" "cluster" {
  image_id        = data.aws_ami.ubuntu.id
  instance_type   = var.instance_type
  security_groups = [aws_security_group.asg.id]

  user_data = <<-EOF
              #!/bin/bash
              echo "Up" > index.html
              nohup busybox httpd -f -p "${var.server_port}" &
              EOF

  lifecycle {
    create_before_destroy = true
  }
}

data "aws_ami" "ubuntu" {
  most_recent = true
  owners      = ["099720109477"] # Canonical

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  filter {
    name   = "architecture"
    values = ["x86_64"]
  }

  filter {
    name   = "image-type"
    values = ["machine"]
  }

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-xenial-16.04-amd64-server-*"]
  }
}

resource "aws_security_group" "asg" {
  name = "${var.name}-asg"
}

resource "aws_security_group_rule" "asg_allow_http_inbound" {
  type              = "ingress"
  from_port         = var.server_port
  to_port           = var.server_port
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.asg.id
}

resource "aws_elb" "cluster" {
  name            = var.name
  subnets         = data.aws_subnet_ids.default.ids
  security_groups = [aws_security_group.elb.id]

  listener {
    lb_port           = var.elb_port
    lb_protocol       = "http"
    instance_port     = var.server_port
    instance_protocol = "http"
  }

  health_check {
    healthy_threshold   = 2
    unhealthy_threshold = 2
    timeout             = 3
    interval            = 30
    target              = "HTTP:${var.server_port}/"
  }
}

resource "aws_security_group" "elb" {
  name = "${var.name}-elb"
}

resource "aws_security_group_rule" "elb_allow_http_inbound" {
  type              = "ingress"
  from_port         = var.elb_port
  to_port           = var.elb_port
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.elb.id
}

resource "aws_security_group_rule" "elb_allow_all_outbound" {
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.elb.id
}
