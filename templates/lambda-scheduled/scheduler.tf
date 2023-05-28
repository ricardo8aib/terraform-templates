# IAM Role for the scheduler
resource "aws_iam_role" "scheduler_role" {
name   = "${var.project}-lambda-scheduler"
assume_role_policy = <<EOF
{
 "Version": "2012-10-17",
 "Statement": [
   {
     "Action": "sts:AssumeRole",
     "Principal": {
       "Service": "scheduler.amazonaws.com"
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

# IAM Policy for the scheduler
resource "aws_iam_policy" "invoke_lambda_policy" {
  name        = "${var.project}-lambda-scheduler-policy"
  description = "A policy that allows a EventBridge scheduler trigger the Lambda function"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid = ""
        Effect   = "Allow"
        Action = [
          "lambda:InvokeFunction"
        ]
        Resource = [
            "${aws_lambda_function.lambda_function.arn}:*",
            "${aws_lambda_function.lambda_function.arn}:"
        ]
      },
    ]
  })
  tags = {
  project = "${var.project}"
}
}

# Attach policy to Lambda Role
resource "aws_iam_role_policy_attachment" "invoke_lambda_policy_attachement" {
  role       = "${aws_iam_role.scheduler_role.name}"
  policy_arn = "${aws_iam_policy.invoke_lambda_policy.arn}"
}


# Scheduler
resource "aws_scheduler_schedule" "lambda_scheduler" {
  name       = "${var.project}-scheduler"

  flexible_time_window {
    mode = "OFF"
  }

  schedule_expression = "cron(0 9 * * ? *)"

  target {
    arn      = aws_lambda_function.lambda_function.arn
    role_arn = aws_iam_role.scheduler_role.arn
  }

}