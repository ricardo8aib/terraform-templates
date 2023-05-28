# IAM role for RDS proxy
resource "aws_iam_role" "rds_proxy_role" {
name   = "${var.project}-rds-proxy-role"
assume_role_policy = <<EOF
{
 "Version": "2012-10-17",
 "Statement": [
   {
     "Action": "sts:AssumeRole",
     "Principal": {
       "Service": "rds.amazonaws.com"
     },
     "Effect": "Allow",
     "Sid": ""
   }
 ]
}
EOF
}

# Policy for RDS Proxy
resource "aws_iam_policy" "rds_proxy_policy" {
  name        = "${var.project}-rds-proxy-policy"

  policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "",
            "Effect": "Allow",
            "Action": [
                "secretsmanager:GetSecretValue"
            ],
            "Resource": [
                "${aws_secretsmanager_secret.rds_secret.arn}"
            ]
        },
        {
            "Sid": "",
            "Effect": "Allow",
            "Action": [
                "kms:Decrypt"
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

# Attach policy to RDS proxy Role
resource "aws_iam_role_policy_attachment" "rds_proxy_policy_attachement" {
  role       = "${aws_iam_role.rds_proxy_role.name}"
  policy_arn = aws_iam_policy.rds_proxy_policy.arn
}