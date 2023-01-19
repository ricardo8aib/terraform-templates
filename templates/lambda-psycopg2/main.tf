# Lambda role to assing to the Lambda function
resource "aws_iam_role" "psycopg2_lambda_role" {
name   = "${var.project}-psycopg2-lambda-role"
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

# Attach policy to Lambda Role
resource "aws_iam_role_policy_attachment" "lambda_basic_execution_policy_attachement" {
  role       = "${aws_iam_role.psycopg2_lambda_role.name}"
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
}

# Create the Lambda function
resource "aws_lambda_function" "templates_lambda" {
filename                       = "lambda_functions.zip"
function_name                  = "${var.project}-psycopg2-lambda"
role                           = aws_iam_role.deals_matcher_lambda_role.arn
handler                        = "${var.project}-lambda.lambda_handler"
runtime                        = "python3.8"
}

