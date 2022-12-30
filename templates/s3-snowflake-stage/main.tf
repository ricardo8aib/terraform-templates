# S3 Bucket
resource "aws_s3_bucket" "stage_bucket" {
  bucket = "${var.project}-snowflake-s3-bucket"
  acl    = "${var.acl}"
  force_destroy = "${var.force-destroy}"

  tags = {
    project = var.project
  }
}

# IAM Role to let Snowflake access to the S3 bucket
resource "aws_iam_role" "snowflake_role" {
  name = "${var.project}-snowflake-s3-role"

  assume_role_policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Principal": {
                "AWS": "${var.aws_account_id}"
            },
            "Action": "sts:AssumeRole",
            "Condition": {
                "StringEquals": {
                    "sts:ExternalId": "0000"
                }
            }
        }
    ]
}
EOF

  tags = {
    project = var.project
  }
}

# IAM Policy to attach to the S3 Role
resource "aws_iam_policy" "snowflake_s3_access_policy" {
  name        = "${var.project}-snowflake-s3-policy"
  description = "Allows the ${aws_iam_role.snowflake_role.name} role access to S3"

  policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "VisualEditor0",
            "Effect": "Allow",
            "Action": [
                "s3:ListBucket",
                "s3:GetBucketLocation"
            ],
            "Resource": "${aws_s3_bucket.stage_bucket.arn}"
        },
        {
            "Sid": "VisualEditor1",
            "Effect": "Allow",
            "Action": [
                "s3:GetObject",
                "s3:GetObjectVersion"
            ],
            "Resource": "${aws_s3_bucket.stage_bucket.arn}/*"
        }
    ]
}
EOF
  tags = {
    project = var.project
  }
}

# Attach the Snowflake Policy to the Snowflake Role
resource "aws_iam_role_policy_attachment" "attach-s3-policy-to-snowflake-role" {
  role       = aws_iam_role.snowflake_role.name
  policy_arn = aws_iam_policy.snowflake_s3_access_policy.arn
}