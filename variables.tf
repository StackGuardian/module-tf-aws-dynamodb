
variable "name" {
    type = string
    description = "Name of the DynamoDB Table"
}

variable "dynamodb_region" {
     type = string
     description = "AWS region where DynamoDB Table should be deployed"
}

variable "billing_mode" {
    type = string
    description = "PROVISIONED or PAY_PER_REQUEST, check https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/dynamodb_table"
}

variable "hash_key" {
    type = string
    description = "DynamoDB primary partition key"
}

variable "range_key" {
    type = string
    description = "DynamoDB primary sort key"
    default = null
}

variable "write_capacity" {
    type = number
    description = "Write Capacity Units (WCUs), check https://calculator.aws/#/createCalculator/amazonDynamoDB"
    default = null
}

variable "read_capacity" {
    type = number
    description = "Read Capacity Units (WCUs), check https://docs.aws.amazon.com/amazondynamodb/latest/developerguide/ProvisionedThroughput.html"
    default = null
}

variable "attributes" {
    type = list(map(string))
    description = <<EOL
    DynamoDB Table attributes, hash_key and sort_key (if given) should be defined here.
    JSON tfvars Example
    "attributes": [
        {
            "name": "HashKeyName",
            "type": "S"
        },
        {
            "name": "RangeKeyName",
            "type": "B"
        }
    ]
    EOL
}

variable "point_in_time_recovery" {
    type = bool
    description = "Allow Point in time recovery of backed up table, check https://docs.aws.amazon.com/amazondynamodb/latest/developerguide/PointInTimeRecovery.html"
    default = false
}

variable "tags" {
    type = map(string)
    description = <<EOL
    Tags for the table.
    JSON tfvars Example
    "tags": {
        "Name": "MyTable",
        "ENVIRONEMNT": "DEV"
    }
    EOL
    default = {}
}

variable "replicas" {
    type = list(string)
    description = "AWS regions for Global DynamoDB Tables V2, check https://docs.aws.amazon.com/amazondynamodb/latest/developerguide/globaltables.V2.html"
    default = null
}

variable "global_secondary_index" {
    type = map
    description = <<EOL
    Seettings for GLobal Secondary Index in the create DynamoDB Table(s), check https://docs.aws.amazon.com/amazondynamodb/latest/developerguide/GSI.html
    If you are using Global Tables and you have defined replicas variable, check https://docs.aws.amazon.com/amazondynamodb/latest/developerguide/globaltables_reqs_bestpractices.html
    JSON tfvars Example
    "global_secondary_index": {
        "name": "MyTable",
        "hash_key": "Title"
        "range_key": "Rating"
        "write_capacity": 10
        "read_capacity": 10
        "projection_type": "INCLUDE"
        "non_key_attributes": ["Authors"] 
    }
    EOL
    default = null
}