output "stage_bucket_arn" {
  description = "ARN of the stage bucket"
  value = "${aws_s3_bucket.stage_bucket.arn}"
}