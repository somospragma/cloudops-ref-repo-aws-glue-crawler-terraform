data "aws_caller_identity" "current" {}

data "aws_iam_policy_document" "glue_policy" {

  dynamic "statement" {
    for_each = var.target_type == "s3" ? [1] : []
    content {
      sid    = "S3AccessForGlue"
      effect = "Allow"
      actions = [
        "s3:ListBucket"
      ]
      resources = [
        "arn:aws:s3:::${var.bucket_id}"
      ]
    }
  }

  dynamic "statement" {
    for_each = var.target_type == "s3" ? [1] : []
    content {
      sid    = "S3ObjectAccessForGlue"
      effect = "Allow"
      actions = [
        "s3:GetObject",
        "s3:PutObject"
      ]
      resources = [
        "arn:aws:s3:::${var.bucket_id}/*"
      ]
    }
  }

  dynamic "statement" {
    for_each = var.target_type == "dynamodb" ? [1] : []
    content {
      sid    = "DynamoAccessForGlue"
      effect = "Allow"
      actions = [
        "dynamodb:DescribeTable"
      ]
      resources = [
        "arn:aws:dynamodb:${var.aws_region}:${data.aws_caller_identity.current.account_id}:table/${var.dynamo_table}"
      ]
    }
  }

  statement {
    sid       = "ec2AccessForGlue"
    effect    = "Allow"
    actions   = [
      "ec2:DescribeSubnets",
      "ec2:DescribeSecurityGroups"
    ]
    resources = [
      "*"
    ]
  }

  statement {
    sid       = "CloudWatchLogsForGlue"
    effect    = "Allow"
    actions   = [
      "logs:CreateLogGroup",
      "logs:CreateLogStream",
      "logs:PutLogEvents"
    ]
    resources = [
      "arn:aws:logs:*:*:*"
    ]
  }

  statement {
    sid       = "GlueServiceBasicActions"
    effect    = "Allow"
    actions   = [
      "glue:GetJob",
      "glue:GetJobRun",
      "glue:BatchGetJobs",
      "glue:StartJobRun",
      "glue:GetConnection",
      "glue:GetConnections",
      "glue:GetDatabase",
      "glue:GetDatabases",
      "glue:GetTable",
      "glue:GetTables"
    ]
    resources = ["*"]
  }
}
