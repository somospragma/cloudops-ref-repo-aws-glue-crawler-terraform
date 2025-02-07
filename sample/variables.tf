variable "client" {
  type = string
}
variable "environment" {
  type = string
}
variable "aws_region" {
  type = string
}
variable "profile" {
  type = string
}
variable "common_tags" {
    type = map(string)
    description = "Tags comunes aplicadas a los recursos"
}
variable "project" {
  type = string  
}
variable "functionality" {
  type = string  
}
variable "application" {
  type = string  
}



########### Varibales Glue_crawler

variable "target_type" {
  description = "Tipo de target para el crawler: s3, dynamodb, jdbc, mongodb"
  type        = string
  default     = "s3"

  validation {
    condition     = contains(["s3", "dynamodb", "jdbc", "mongodb"], var.target_type)
    error_message = "El valor de target_type debe ser uno de: s3, dynamodb, jdbc o mongodb."
  }
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




