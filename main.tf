###### IAM
resource "aws_iam_role" "glue_execution_role" {
  name = "${var.client}-${var.project}-${var.environment}-${var.application}-role-${var.functionality}"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Principal = {
          Service = "glue.amazonaws.com"
        }
        Action = "sts:AssumeRole"
      }
    ]
  })
}

resource "aws_iam_policy" "glue_minimal_policy" {
  name        = "${var.client}-${var.project}-${var.environment}-${var.application}-policy-${var.functionality}"
  description = "Política mínima para AWS Glue"
  policy      = data.aws_iam_policy_document.glue_policy.json
}

resource "aws_iam_policy_attachment" "glue_policy_attachment" {
  name       = "${var.client}-${var.project}-${var.environment}-${var.application}-policy-attachment-${var.functionality}"
  roles      = [aws_iam_role.glue_execution_role.name]
  policy_arn = aws_iam_policy.glue_minimal_policy.arn
}


#######  Glue Database Catalog

resource "aws_glue_catalog_database" "glue_catalog" {
  name = "${var.client}-${var.project}-${var.environment}-${var.application}-catalogdatabase-${var.functionality}"
  create_table_default_permission {
    permissions = ["SELECT"]
    principal {
      data_lake_principal_identifier = "IAM_ALLOWED_PRINCIPALS"
    }
  }
}


#######  Glue Connection

resource "aws_glue_connection" "jdbc" {
  count = contains(["jdbc"], lower(var.target_type)) ? 1 : 0
  name            = "${var.client}-${var.project}-${var.environment}-${var.application}-connection-${var.functionality}"
  connection_type = "JDBC"
  connection_properties = {
    JDBC_CONNECTION_URL = var.connection
    USERNAME            = var.username
    PASSWORD            = var.password
  }
  physical_connection_requirements {
    subnet_id              = var.subnet
    security_group_id_list = [var.security_group_id_list]
    availability_zone      = var.aws_region
  }
}

resource "aws_glue_connection" "mongodb" {
  count = contains(["mongodb"], lower(var.target_type)) ? 1 : 0
  name            = "${var.client}-${var.project}-${var.environment}-${var.application}-connection-${var.functionality}"
  connection_type = "MONGODB"
  connection_properties = {
    CONNECTION_URL      = var.connection
  }
  physical_connection_requirements {
    subnet_id              = var.subnet
    security_group_id_list = [var.security_group_id_list]
  }
}



######  Crawler

resource "aws_glue_crawler" "glue_crawler" {
  database_name = aws_glue_catalog_database.glue_catalog.name
  name          = "${var.client}-${var.project}-${var.environment}-${var.application}-crawler-${var.functionality}"
  role          = aws_iam_role.glue_execution_role.arn

  dynamic "s3_target" {
    for_each = var.target_type == "s3" ? [1] : []
    content {
      path = "s3://${var.bucket_id}"
    }
  }

  dynamic "dynamodb_target" {
    for_each = var.target_type == "dynamodb" ? [1] : []
    content {
      path = var.dynamo_table
    }
  }

  dynamic "jdbc_target" {
    for_each = var.target_type == "jdbc" ? [1] : []
    content {
      connection_name = aws_glue_connection.jdbc[0].name
      path            = "${var.db_name}/%"
    }
  }

  dynamic "mongodb_target" {
    for_each = var.target_type == "mongodb" ? [1] : []
    content {
      connection_name = aws_glue_connection.mongodb[0].name
      path            = "${var.db_name}/%"
    }
  }
  depends_on = [
    aws_glue_connection.jdbc,
    aws_glue_connection.mongodb
  ]
}

