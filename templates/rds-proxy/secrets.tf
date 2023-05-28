# 
resource "aws_secretsmanager_secret" "rds_secret" {
  name_prefix = "rds-proxy-secret"
  recovery_window_in_days = 7
  description = "Secret for RDS Proxy"
}

resource "aws_secretsmanager_secret_version" "rds_secret_version" {
  secret_id     = aws_secretsmanager_secret.rds_secret.id
  secret_string = jsonencode({
    "username"             = "my_username"
    "password"             = "my_password"
    "engine"               = "mysql"
    "host"                 = aws_db_instance.rds_instance.address
    "port"                 = 3306
    "dbInstanceIdentifier" = aws_db_instance.rds_instance.id
  })
}