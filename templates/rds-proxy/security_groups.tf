# Create a security group for the RDS proxy
resource "aws_security_group" "rds_proxy_security_group" {
  name = "${var.project}_rds_proxy_security_group"
  vpc_id = aws_vpc.rds_vpc.id
  ingress {
    description      = "MySQL TLS from lambda_security_group"
    from_port        = 3306
    to_port          = 3306
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    # security_groups  = []
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
  }
}


# Create a security group for RDS Database Instance
resource "aws_security_group" "rds_security_group" {
  name = "${var.project}_rds_security_group"
  vpc_id = aws_vpc.rds_vpc.id
  ingress {
    from_port       = 3306
    to_port         = 3306
    protocol        = "tcp"
    security_groups  = [aws_security_group.rds_proxy_security_group.id]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}