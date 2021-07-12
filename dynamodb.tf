
resource "aws_dynamodb_table" "main" {
  name           = var.name
  billing_mode   = var.billing_mode
  hash_key       = var.hash_key
  range_key      = var.range_key
  write_capacity = var.write_capacity
  read_capacity  = var.read_capacity

  dynamic "attribute" {
    for_each = var.attributes
    content {
      name = attribute.value["name"]
      type = attribute.value["type"]
    }
  }

  dynamic "global_secondary_index" {
    for_each = var.global_secondary_indexes
    content {
      name               = global_secondary_index.value["name"]
      hash_key           = global_secondary_index.value["hash_key"]
      range_key          = lookup(global_secondary_index.value, "range_key", null)
      write_capacity     = lookup(global_secondary_index.value, "write_capacity", null)
      read_capacity      = lookup(global_secondary_index.value, "read_capacity", null)
      projection_type    = global_secondary_index.value["projection_type"]
      non_key_attributes = lookup(global_secondary_index.value, "non_key_attributes", null)
    }
  }

  dynamic "replica" {
    for_each = var.replicas
    content {
      region_name = replica.value["name"]
    }
  }

  point_in_time_recovery {
    enabled = var.point_in_time_recovery
  }

  tags = var.tags

  # dynamic "lifecycle" {
  #     # When auto_scaling, set ignore_changes for read_capacity and/or write_capacity
  #       ignore_changes: ["read_capacity", "write_capacity"]
  # }
}