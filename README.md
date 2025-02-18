# **🚀 Módulo Terraform para Glue Crawler: cloudops-ref-repo-aws-glue_crawler-terraform**

## Descripción:

Este módulo de Terraform permite la creación y configuración de recursos necesarios para ejecutar un Glue Crawler en AWS. Se incluyen:

- **IAM:** Creación de un rol de ejecución, política mínima y su asignación para AWS Glue.
- **Glue Catalog Database:** Configuración de la base de datos del catálogo de Glue.
- **Glue Connection:** Creación de conexiones para targets de tipo JDBC o MongoDB (según el valor de la variable `target_type`).
- **Crawler:** Configuración del Glue Crawler, que puede apuntar a diferentes fuentes de datos: S3, DynamoDB, JDBC o MongoDB.

Previamente se deben crear:

- **bucket_id:** ID de un bucket S3 (Cuando el target es S3)
- **dynamo_table:** Nombre de la table de Dynamo (Cuando el target es DynamoDB)
- **subnet:** ID de la subnet (Cuando el taget es JDBC o MONGODB)
- **security_group_id_list:** ID del security group (Cuando el target es JDBC o MONGODB)
  
Consulta CHANGELOG.md para la lista de cambios de cada versión. *Recomendamos encarecidamente que en tu código fijes la versión exacta que estás utilizando para que tu infraestructura permanezca estable y actualices las versiones de manera sistemática para evitar sorpresas.*

## Estructura del Módulo

El módulo cuenta con la siguiente estructura:

```bash
cloudops-ref-repo-aws-glue_crawler-terraform/
└── sample/
    ├── data.tf
    ├── main.tf
    ├── outputs.tf
    ├── providers.tf
    ├── terraform.auto.tfvars
    └── variables.tf
├── CHANGELOG.md
├── README.md
├── data.tf
├── locals.tf
├── main.tf
├── outputs.tf
├── variables.tf
```

- Los archivos principales del módulo (`data.tf`, `main.tf`, `outputs.tf`, `variables.tf`, `locals.tf`) se encuentran en el directorio raíz.
- `CHANGELOG.md` y `README.md` también están en el directorio raíz para fácil acceso.
- La carpeta `sample/` contiene un ejemplo de implementación del módulo.


## Uso del Módulo:

```hcl
module "glue_crawler" {
  source        = "module/glue_crawler"

  client        = "xxxx"
  project       = "xxxx"
  environment   = "xxxx"
  application   = "xxxx"
  functionality = "xxxx"
  
  # Variables para el Crawler
  target_type   = "xxxx"       # Opciones: "s3", "dynamodb", "jdbc", "mongodb"
  db_name       = "xxxx"       


  bucket_id     = "xxxx"       # Requerido si target_type es "s3"
  dynamo_table  = "xxxx"       # Requerido si target_type es "dynamodb"

  
  # Variables para la conexión (para jdbc o mongodb)
  connection             = "xxxx"
  username               = "xxxx"
  password               = "xxxx"
  subnet                 = "xxxx"
  security_group_id_list = "xxxx"
  aws_region             = "xxxx"
```
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.13.1 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 4.31.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws.project"></a> [aws.project](#provider\_aws) | >= 4.31.0 |

## Resources

| Name | Type |
|------|------|
| [aws_iam_role.glue_execution_role](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_policy.glue_minimal_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy) | resource |
| [aws_iam_policy_attachment.glue_policy_attachment](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy_attachment) | resource |
| [aws_glue_catalog_database.glue_catalog](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/glue_catalog_database) | resource |
| [aws_glue_connection.jdbc](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/glue_connection) | resource |
| [aws_glue_connection.mongodb](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/glue_connection) | resource |
| [aws_glue_crawler.glue_crawler](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/glue_crawler) | resource |

## 📌 Variables

| Variable                      | Tipo         | Predeterminado | Obligatorio | Descripción                                                                                                                  |
|-------------------------------|--------------|----------------|-------------|------------------------------------------------------------------------------------------------------------------------------|
| `client`                      | `string`     | —              | Sí          | Nombre del cliente.                                                                                                          |
| `project`                     | `string`     | —              | Sí          | Nombre del proyecto.                                                                                                         |
| `environment`                 | `string`     | —              | Sí          | Nombre del ambiente.                                                                                                         |
| `application`                 | `string`     | —              | Sí          | Nombre de la aplicación (por ejemplo, "glue").                                                                               |
| `functionality`               | `string`     | —              | Sí          | Nombre de la funcionalidad que desempeña el recurso.                                                                       |
| `target_type`                 | `string`     | `s3`           | No          | Tipo de target para el crawler. Valores aceptados: `s3`, `dynamodb`, `jdbc`, `mongodb`.                                      |
| `bucket_id`                   | `string`     | —              | Sí*         | Nombre del bucket S3 para target tipo `s3`. (*Obligatorio si `target_type` es `s3`.)                                          |
| `dynamo_table`                | `string`     | —              | Sí*         | Nombre de la tabla para target tipo `dynamodb`. (*Obligatorio si `target_type` es `dynamodb`.)                                |
| `db_name`                     | `string`     | —              | Sí*         | Nombre de la base de datos para conexiones de tipo `jdbc` o `mongodb`.                                                       |
| `connection`                  | `string`     | —              | Sí*         | URL de conexión a la base de datos (para targets `jdbc` o `mongodb`).                                                        |
| `username`                    | `string`     | —              | Sí*         | Usuario para la conexión JDBC. (*Obligatorio para `jdbc`)*                                                                   |
| `password`                    | `string`     | —              | Sí*         | Contraseña para la conexión JDBC. (*Obligatorio para `jdbc`)*                                                                |
| `subnet`                      | `string`     | —              | Sí          | ID de la subnet con acceso a la base de datos (usado en conexiones JDBC y MongoDB).                                          |
| `security_group_id_list`      | `string`     | —              | Sí          | ID del Security Group con acceso a la base de datos (usado en conexiones JDBC y MongoDB).                                    |
| `aws_region`                  | `string`     | —              | Sí          | Región de AWS donde se desplegarán los recursos.                                                                           |

### 📤 Outputs

| Output                | Tipo     | Descripción                                                         |
|-----------------------|----------|---------------------------------------------------------------------|
| `glue_crawler_name`   | `string` | Nombre del crawler de AWS Glue creado.                              |


