# Security group for the airflow SERVER
resource "aws_security_group" "airflow_security_group" {
  name        = "${var.project}-airflow-sg"
  description = "Security group for airflow EC2 instance"

  tags = {
    Name    = "${var.project}-airflow-sg"
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



# AWS key pair for airflow instance
resource "tls_private_key" "airflow_private_key" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "aws_key_pair" "aws_key_pair_airflow" {
  key_name   = "${var.project}-airflow"
  public_key = tls_private_key.airflow_private_key.public_key_openssh

  provisioner "local-exec" {
    command = "echo '${tls_private_key.airflow_private_key.private_key_pem}' > ./keys/airflow-${var.project}.pem"
  }
}

# airflow EC2 Instance
resource "aws_instance" "airflow_instance" {

  ami                    = "${var.instance-ami}"
  instance_type          = "${var.instance-type}.${var.instance-size}"
  vpc_security_group_ids = [aws_security_group.airflow_security_group.id]
  key_name               = aws_key_pair.aws_key_pair_airflow.key_name
  user_data              = <<-EOF
    #!/bin/bash
    cd /home/ubuntu
    sudo apt update
    sudo apt install apt-transport-https ca-certificates curl software-properties-common -y
    sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
    sudo echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
    sudo apt update
    sudo apt install docker-ce -y
    sudo mkdir -p ~/.docker/cli-plugins/
    sudo curl -SL https://github.com/docker/compose/releases/download/v2.3.3/docker-compose-linux-x86_64 -o ~/.docker/cli-plugins/docker-compose
    sudo chmod +x ~/.docker/cli-plugins/docker-compose
    sudo curl -LfO 'https://airflow.apache.org/docs/apache-airflow/2.4.3/docker-compose.yaml'
    sudo mkdir -p ./dags ./logs ./plugins
    sudo echo -e "AIRFLOW_UID=$(id -u)" > .env
    sudo docker compose up airflow-init
    sudo docker compose up -d
  EOF

  tags = {
    Name    = "${var.project}-airflow-instance"
    project = var.project
  }
}
