#Globales
variable "client" {
  description = "Nombre del cliente"
  type        = string
}

variable "project" {
  description = "Nombre del proyecto"
  type        = string
}

variable "environment" {
  description = "Nombre del ambiente"
  type        = string
}

variable "application" {
  description = "Nombre de la aplicación en este caso puede ser glue"
  type        = string
}

variable "functionality" {
  description = "Nombre de la funcionalidad que tiene como objetivo desempeñar el recurso"
  type        = string
}


# Glue Crawler

variable "target_type" {
  description = "Tipo de target para el crawler: s3, dynamodb, jdbc, mongodb"
  type        = string
  default     = "s3"
}


variable "bucket_id" {
  description = "Nombre del Bucket habilitado para target tipo s3"
  type        = string
}


variable "dynamo_table" {
  description = "Nombre de la tabla habilitado para tipo dynamodb"
  type        = string
}


variable "db_name" {
  description = "Nombre de la base de datos a la que se va a conectar habilitado para target tipo mongodb y jdbc"
  type        = string
}


#Glue Connection


variable "connection" {
  description = "Punto de conexion a la base de datos segun tipo JDBC o MONGODB"
  type        = string
}

variable "username" {
  description = "Username Base de datos"
  type        = string
}

variable "password" {
  description = "Password base de datos"
  type        = string
}

variable "subnet" {
  description = "Subnet con acceso a base de datos"
  type        = string
}

variable "security_group_id_list" {
  description = "Security group con acceso a base de datos"
  type        = string
}

variable "aws_region" {
  description = "Region"
  type        = string
}

