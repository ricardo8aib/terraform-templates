output "ecr_repository_uri" {
  value = aws_ecr_repository.repository.repository_url
}