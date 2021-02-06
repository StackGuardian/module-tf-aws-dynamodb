output "id" {
  value       = aws_dynamodb_table.id
  sensitive   = false
  description = "description"
  depends_on  = []
}
