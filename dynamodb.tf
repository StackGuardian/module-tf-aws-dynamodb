
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

  #  TODO: global_secondary_index and replica
  global_secondary_index {
    name               = "GameTitleIndex"
    hash_key           = "GameTitle"
    range_key          = "TopScore"
    write_capacity     = 10
    read_capacity      = 10
    projection_type    = "INCLUDE"
    non_key_attributes = ["UserId"]
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