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
}

# Create the Lambda function
resource "aws_lambda_function" "templates_simple_lambda" {
filename                       = "lambda_functions.zip"
function_name                  = "${var.project}-lambda-function"
role                           = aws_iam_role.lambda_role.arn
handler                        = "${var.project}-lambda.lambda_handler"
runtime                        = "python3.8"
timeout                        = 15
memory_size                    = 128
}

