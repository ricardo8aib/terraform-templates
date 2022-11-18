# Output for the public DNS of the EC2 instance
output "simple_ec2_dns" {
  value = aws_instance.ec2_instance.public_dns
}