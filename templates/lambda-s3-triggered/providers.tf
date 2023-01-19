terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.14.0"
    }
    github = {
      source  = "integrations/github"
      version = "~> 4.0"
    }
  }
}

provider "aws" {
  profile = "${var.profile}"
  region  = "${var.region}"
  default_tags {
    tags = {
      comments  = "this resource is managed by terraform"
      terraform = "true"
    }
  }
}