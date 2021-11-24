resource "aws_security_group" "validator_node_security_group" {
  description = var.sg_description
  vpc_id      = aws_vpc.indy_vpc.id

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
    Name     = "${var.instance_name} - Security Group"
    Instance = var.instance_name
  }
}

resource "aws_security_group" "validator_client_ssh_security_group" {
  description = var.sg_description
  vpc_id      = aws_vpc.indy_vpc.id

  egress {
    cidr_blocks = ["0.0.0.0/0"]
    from_port   = "0"
    protocol    = "-1"
    self        = "false"
    to_port     = "0"
  }

  ingress {
    cidr_blocks      = ["0.0.0.0/0"]
    from_port        = "22"
    ipv6_cidr_blocks = ["::/0"]
    protocol         = "tcp"
    self             = "false"
    to_port          = "22"
  }

  tags = {
    Name     = "${var.instance_name} - Security Group SSH"
    Instance = var.instance_name
  }
}

