###############################################################
# Variables Globales
###############################################################


aws_region         = "us-east-1"
profile            = "pra_idp_dev"
environment        = "dev"
client             = "pragma"
project            = "hefesto"
functionality      = "sample"  
application        = "glue"

common_tags = {
  environment   = "dev"
  project-name  = "Modulos Referencia"
  cost-center   = "-"
  owner         = "cristian.noguera@pragma.com.co"
  area          = "KCCC"
  provisioned   = "terraform"
  datatype      = "interno"
}


###############################################################
# Variables Glue Job
###############################################################


target_type = "s3"
db_name     = "hefesto"
#connection  = "jdbc:<motor>://<endpoint>:<puerto>/<dbname>" #ejemplo para jdbc
username    = "prueba"
password    = "123456"

