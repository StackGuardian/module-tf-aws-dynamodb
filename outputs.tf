output "id" {
  value       = aws_dynamodb_table.main.id
  sensitive   = false
  description = "description"
  depends_on  = []
}
