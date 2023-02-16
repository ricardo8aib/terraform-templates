resource "aws_dynamodb_table" "simple_dynamodb_table" {
  name           = "${var.project}-simple-dynamo-table"
  billing_mode   = "PROVISIONED"
  read_capacity  = 1
  write_capacity = 1
  hash_key       = "name"

  attribute {
    name = "name"
    type = "S"
  }

  attribute {
    name = "role"
    type = "S"
  }

  global_secondary_index {
    name               = "Role-Index"
    hash_key           = "role"
    write_capacity     = 1
    read_capacity      = 1
    projection_type    = "INCLUDE"
    non_key_attributes = ["summary", "email", "skills"]
  }

  ttl {
    attribute_name = "TimeToExist"
    enabled        = false
  }

  tags = {
    project = var.project
  }
}