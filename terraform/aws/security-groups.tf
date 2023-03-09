resource "aws_security_group" "validator_node_security_group" {
  description = var.candy_sg_description

  egress {
    cidr_blocks = ["0.0.0.0/0"]
    from_port   = "0"
    protocol    = "-1"
    self        = "false"
    to_port     = "0"
  }

  ingress {
    cidr_blocks      = ["0.0.0.0/0"]
    from_port        = "9701"
    ipv6_cidr_blocks = ["::/0"]
    protocol         = "tcp"
    self             = "false"
    to_port          = "9709"
  }

  tags = {
    Name     = "${var.candy_instance_name} - Security Group"
    Instance = var.candy_instance_name
  }
}

resource "aws_security_group_rule" "node_security_group_rule_ssh" {
  type              = "ingress"
  description       = "Allow ssh - intended of use with Ansible."
  cidr_blocks       = [var.candy_ssh_source_address]
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  security_group_id = aws_security_group.validator_node_security_group.id
}
