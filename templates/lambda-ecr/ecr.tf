resource "aws_ecr_repository" "repository" {
  name                 = "${var.project}-repository"
  image_tag_mutability = "MUTABLE"
  force_delete         = true

  image_scanning_configuration {
    scan_on_push = true
  }
  tags = { project = "${var.project}" }
}