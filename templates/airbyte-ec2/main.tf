# Security group for the AIRBYTE SERVER
resource "aws_security_group" "airbyte_security_group" {
  name        = "${var.project}-airbyte-sg"
  description = "Security group for AIRBYTE EC2 instance"

  tags = {
    Name    = "${var.project}-airbyte-sg"
    project = var.project
  }

ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    description = "for all outgoing traffics"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}


# AWS key pair for airbyte instance
resource "tls_private_key" "airbyte_private_key" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "aws_key_pair" "aws_key_pair_airbyte" {
  key_name   = "${var.project}-airbyte"
  public_key = tls_private_key.airbyte_private_key.public_key_openssh

  provisioner "local-exec" {
    command = "echo '${tls_private_key.airbyte_private_key.private_key_pem}' > ./keys/airbyte-${var.project}.pem"
  }
}

# airbyte EC2 Instance
resource "aws_instance" "airbyte_instance" {

  ami                    = "${var.instance-ami}"
  instance_type          = "${var.instance-type}.${var.instance-size}"
  vpc_security_group_ids = [aws_security_group.airbyte_security_group.id]
  key_name               = aws_key_pair.aws_key_pair_airbyte.key_name
  user_data              = <<-EOF
    #!/bin/bash
    cd /home/ubuntu

    sudo apt update
    sudo snap install docker

    curl -L "https://github.com/docker/compose/releases/download/1.26.0/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
    chmod +x /usr/local/bin/docker-compose

    git clone https://github.com/airbytehq/airbyte.git
    cd airbyte
    sudo docker-compose up
  EOF

  tags = {
    Name    = "${var.project}-airbyte-instance"
    project = var.project
  }
}