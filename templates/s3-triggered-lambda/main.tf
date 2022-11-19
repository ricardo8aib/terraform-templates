# S3 Bucket
resource "aws_s3_bucket" "staging_bucket" {
  bucket = "${var.bucket_name}"
  force_destroy = true

  tags = {
    Name    = "${var.project}"
  }
}

# Lambda role to assing to the Lambda function
resource "aws_iam_role" "templates_lambda_role" {
name   = "${var.project}-lambda-role"
assume_role_policy = <<EOF
{
 "Version": "2012-10-17",
 "Statement": [
   {
     "Action": "sts:AssumeRole",
     "Principal": {
       "Service": "lambda.amazonaws.com"
     },
     "Effect": "Allow",
     "Sid": ""
   }
 ]
}
EOF
}

# IAM Policy to attach to let the lambda function access S3
resource "aws_iam_policy" "templates_lambda_access_policy" {
  name        = "${var.project}-access-policy"
  description = "Allows the ${aws_iam_role.templates_lambda_role.name} role access to S3"

  policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "VisualEditor0",
            "Effect": "Allow",
            "Action": [
                "s3:PutObject",
                "s3:GetObject",
                "logs:CreateLogDelivery",
                "logs:PutMetricFilter",
                "logs:CreateLogStream",
                "logs:GetLogRecord",
                "logs:DeleteLogGroup",
                "logs:GetLogEvents",
                "logs:FilterLogEvents",
                "logs:GetLogGroupFields",
                "logs:CreateLogGroup",
                "logs:DeleteLogStream",
                "logs:GetLogDelivery",
                "logs:PutLogEvents"
            ],
            "Resource": "*"
        }
    ]
}
EOF
  tags = {
    Name    = "${var.project}"
  }
}

# Attach the policy to the lambda function
resource "aws_iam_role_policy_attachment" "attach_lambda_policy_to_lambda_role" {
  role       = aws_iam_role.templates_lambda_role.name
  policy_arn = aws_iam_policy.templates_lambda_access_policy.arn
}


# Create the Lambda function
resource "aws_lambda_function" "templates_triggered_lambda" {
filename                       = "lambda_functions.zip"
function_name                  = "${var.project}-s3-triggered-lambda"
role                           = aws_iam_role.templates_lambda_role.arn
handler                        = "s3-triggered-lambda.lambda_handler"
runtime                        = "python3.8"
depends_on                     = [aws_iam_role_policy_attachment.attach_lambda_policy_to_lambda_role]
}

# Add S3 bucket as trigger
resource "aws_s3_bucket_notification" "templates_lambda_trigger" {
  bucket = aws_s3_bucket.staging_bucket.id
  lambda_function {
    lambda_function_arn = aws_lambda_function.templates_triggered_lambda.arn
    events              = ["s3:ObjectCreated:Put"]
    filter_suffix       = ".jsonl"
    filter_prefix       = "raw/"
  }
}

# Add the permission for the S3 bucket to invoke the function
resource "aws_lambda_permission" "permission_to_invoke_templates_lambda" {
  statement_id  = "AllowS3Invoke"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.templates_triggered_lambda.function_name
  principal     = "s3.amazonaws.com"
  source_arn    = aws_s3_bucket.staging_bucket.arn
}
