# Create a RDS Database Instance
resource "aws_db_instance" "rds_instance" {
  db_name = "rdsdb"
  engine               = "mysql"
  engine_version       = "5.7"
  identifier           = "rdsinstanceidentifier"
  allocated_storage    =  20
  max_allocated_storage = 50 # Autoscaling (This will only work with instances that support the feature) 
  instance_class       = "db.t2.micro"
  username             = "${var.db_username}"
  password             = "${var.db_password}"
  parameter_group_name = "default.mysql5.7"
  db_subnet_group_name = aws_db_subnet_group.db_subnet_group.name
  vpc_security_group_ids = ["${aws_security_group.rds_security_group.id}"]
  skip_final_snapshot  = true
  publicly_accessible =  true
}