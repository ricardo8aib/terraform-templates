# IAM role for the Lambda function
resource "aws_iam_role" "lambda_role" {
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
tags = {
  project = "${var.project}"
}
}

# Attach Execution policy to Lambda Role
resource "aws_iam_role_policy_attachment" "lambda_basic_execution_policy_attachement" {
  role       = "${aws_iam_role.lambda_role.name}"
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
}


# Create the Lambda function
resource "aws_lambda_function" "lambda_function" {
image_uri                      = "${aws_ecr_repository.repository.repository_url}:latest"
function_name                  = "${var.project}-lambda-function"
role                           = aws_iam_role.lambda_role.arn
architectures                  = ["arm64"]
package_type                   = "Image"
timeout                        = 360
memory_size                    = 256
tags                           = {project = "${var.project}"}
}
