module "glue_crawler" {
  source = "./module/glue_crawler"

  # Variables de nombramiento
  client        = var.client
  project       = var.project
  environment   = var.environment
  application   = var.application
  functionality = var.functionality

  # Variables genericas
  target_type       = var.target_type
  
  #solo target s3
  bucket_id         = data.aws_s3_bucket.nombre_bucket.id

  #solo target dynamo
  dynamo_table      = data.aws_dynamodb_table.glue_crawler.name
  
  #solo target JDBC o Mongo
  db_name           = var.db_name
  connection        = var.connection
  username          = var.username
  password          = var.password
  subnet            = data.aws_subnet.database_subnet_1.id
  security_group_id_list  = data.aws_security_group.glue_crawler.id
  aws_region        = var.aws_region
}
