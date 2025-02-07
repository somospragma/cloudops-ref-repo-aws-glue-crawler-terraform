output "glue_crawler_name" {
  description = "Nombre del crawler de AWS Glue creado"
  value       = aws_glue_crawler.glue_crawler.name
}