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

variable "db_username" {
  type        = string
  description = "DB username"
}

variable "db_password" {
  type        = string
  description = "DB password"
}