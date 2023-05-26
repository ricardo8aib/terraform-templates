# Create a security group for RDS Database Instance
resource "aws_security_group" "rds_security_group" {
  name = "${var.project}_rds_security_group"
  ingress {
    from_port       = 3306
    to_port         = 3306
    protocol        = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    project = var.project
  }
}

# Create a RDS Database Instance
resource "aws_db_instance" "rds_instance" {
  db_name = "rdsdb"
  engine               = "mysql"
  engine_version       = "5.7"
  identifier           = "rdsinstanceidentifier"
  allocated_storage    =  20
  max_allocated_storage = 50 # Autoscaling (This will only work with instances that support the feature) 
  instance_class       = "db.t2.micro"
  username             = "username"
  password             = "password"
  parameter_group_name = "default.mysql5.7"
  # db_subnet_group_name (Optional) Name of DB subnet group.
  # DB instance will be created in the VPC associated with the DB subnet group.
  # If unspecified, will be created in the default VPC
  vpc_security_group_ids = ["${aws_security_group.rds_security_group.id}"]
  skip_final_snapshot  = true
  publicly_accessible =  true
  tags = {
    project = var.project
  }
}