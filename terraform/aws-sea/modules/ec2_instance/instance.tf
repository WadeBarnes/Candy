data "aws_ami" "ubuntu" {
  most_recent = true
  owners      = var.ec2_owners

  filter {
    name   = "name"
    values = var.ec2_filter_name
  }
  filter {
    name = "root-device-type"
    values = var.ec2_root_device_type
  }
  filter {
    name   = "virtualization-type"
    values = var.ec2_filter_virtualization_type
  }
}

data "aws_vpc" "selected" {
  # Allows dynamic lookup of information about the default VPC.
  # Specifically it's ID
  tags = {
    Name = "Dev_vpc"
  }
}

data "aws_subnet" "selected" {
  # Allows dynamic lookup of information about the given default subnet.
  # Specifically it's ID
  tags = { 
    Name = "Web_Dev_aza_net" 
    }
}

resource "aws_instance" "validator_node_server" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = var.ec2_instance_type

  # ===============================================================
  # Provinces Hosting in AWS will want to ensure their
  # nodes are in different availability zones
  # ---------------------------------------------------------------
  # availability_zone           = "ca-central-1d"
  # ===============================================================

  root_block_device {
    volume_size = var.ebs_volume_size
    volume_type = var.ebs_volume_type
    encrypted   = var.ebs_encrypted
    # ===============================================================
    # This ID is specific to a specific account:
    #   - Encrypted volume required?
    #     - For this the AMI being used; yes.
    #     - Seems to be specific to the Protected B environment.
    #   - Make dynamic if using an encrypted volume
    #   - Keys will need to be protected from accedental distruction
    # ---------------------------------------------------------------
    kms_key_id            = var.ebs_kms_key_id
    # ===============================================================
    delete_on_termination = var.ebs_delete_on_termination

    tags = {
      Name        = var.ebs_name
      Application = var.aws_application
      Environment = var.aws_environment
    }
  }

  network_interface {
    network_interface_id = aws_network_interface.validator_node_node_interface.id
    device_index         = 0
  }

   network_interface {
    network_interface_id = aws_network_interface.validator_node_client_interface.id
    device_index         = 1
  }


  tags = {
    Name        = var.ec2_instance_name
    Application = var.aws_application
    Environment = var.aws_environment
  }
}

resource "aws_security_group" "validator_node_security_group" {
  name        = var.sg_name
  description = var.sg_description
  vpc_id      = data.aws_vpc.selected.id
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

  ingress {
    cidr_blocks      = ["0.0.0.0/0"] //TODO
    from_port        = "22"
    ipv6_cidr_blocks = ["::/0"]
    protocol         = "tcp"
    self             = "false"
    to_port          = "22"
  }

  tags = {
    Name        = var.sg_tag_name
    Application = var.aws_application
    Environment = var.aws_environment
  }
}
resource "aws_network_interface" "validator_node_node_interface" {
  description        = var.eni_node_description
  ipv6_address_count = "0"
  private_ip         = var.eni_node_ip
  private_ips        = [var.eni_node_ip]
  private_ips_count  = "0"
  security_groups    = [aws_security_group.validator_node_security_group.id]
  source_dest_check  = "true"
  subnet_id          = data.aws_subnet.selected.id

  tags = {
    Name        = var.eni_node_name
    Application = var.aws_application
    Environment = var.aws_environment
  }
}

resource "aws_network_interface" "validator_node_client_interface" {
  description        = var.eni_client_description
  ipv6_address_count = "0"
  private_ip         = var.eni_client_ip
  private_ips        = [var.eni_client_ip]
  private_ips_count  = "0"
  security_groups    = [aws_security_group.validator_node_security_group.id]
  source_dest_check  = "true"
  subnet_id          = data.aws_subnet.selected.id

  tags = {
    Name        = var.eni_client_name
    Application = var.aws_application
    Environment = var.aws_environment
  }
}