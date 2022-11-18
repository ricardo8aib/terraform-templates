# S3 Bucket
resource "aws_s3_bucket" "s3_bucket" {
  bucket = "${var.project}-simple-s3-bucket"
  acl    = "${var.acl}"
  force_destroy = "${var.force-destroy}"

  tags = {
    project = var.project
  }
}
