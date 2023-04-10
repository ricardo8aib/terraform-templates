# S3 Bucket
resource "aws_s3_bucket" "s3_bucket" {
  bucket = "${local.envs["BUCKET_NAME"]}"
  acl    = "${local.envs["ACL"]}"
  force_destroy = "${local.envs["FORCE_DESTROY"]}"

  tags = {
    project = "${local.envs["PROJECT"]}"
  }
}
