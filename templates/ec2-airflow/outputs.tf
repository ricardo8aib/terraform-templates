# Output for the public DNS of the EC2 instance
output "airflow_ec2_dns" {
  value = aws_instance.airflow_instance.public_dns
}