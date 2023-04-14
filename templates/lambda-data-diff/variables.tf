variable "profile" {
  type        = string
  description = "AWS profile to run Terraform"
}

variable "region" {
  type        = string
  description = "Region to use for provisioning"
}

variable "project" {
  type        = string
  description = "Project tag for the resources"
}

variable "lambda-role-name" {
  type        = string
  description = "Name for the IAM role that will be assigned to the lambda function"
}

variable "lambda-function-name" {
  type        = string
  description = "Name for the lambda function"
}
