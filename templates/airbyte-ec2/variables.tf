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

variable "instance-size" {
  type        = string
  description = "Size of the instance"
}

variable "instance-type" {
  type        = string
  description = "Instance type, e.g. 't2'"
}

variable "instance-ami" {
  type        = string
  description = "Instance AMI, e.g. 'ami-052efd3df9dad4825'"
}