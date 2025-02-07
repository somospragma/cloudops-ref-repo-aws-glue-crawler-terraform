data "aws_caller_identity" "current" {}

data "aws_s3_bucket" "nombre_bucket" {
  bucket = ""
}


data "aws_subnet" "database_subnet_1" {
  filter {
    name   = "tag:Name"
    values = [""] 
  }
}

data "aws_security_group" "glue_crawler" {
  name   = ""
}

data "aws_dynamodb_table" "glue_crawler" {
  name = ""
}