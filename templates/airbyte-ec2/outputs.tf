# Output for the public DNS of the EC2 instance
output "airbyte_ec2_dns" {
  value = aws_instance.airbyte_instance.public_dns
}