# module-tf-aws-dynamodb
AWS DynamoDB Terraform module

----

#### Terraform Registry
https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/dynamodb_table

----

## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| aws | n/a |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| attributes | DynamoDB Table attributes, hash\_key and sort\_key (if given) should be defined here.<br>    JSON tfvars Example<br>    "attributes": [<br>        {<br>            "name": "HashKeyName",<br>            "type": "S"<br>        },<br>        {<br>            "name": "RangeKeyName",<br>            "type": "B"<br>        }<br>    ] | `list(map(string))` | n/a | yes |
| billing\_mode | PROVISIONED or PAY\_PER\_REQUEST, check https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/dynamodb_table | `string` | n/a | yes |
| global\_secondary\_index | Seettings for GLobal Secondary Index in the create DynamoDB Table(s), check https://docs.aws.amazon.com/amazondynamodb/latest/developerguide/GSI.html<br>    If you are using Global Tables and you have defined replicas variable, check https://docs.aws.amazon.com/amazondynamodb/latest/developerguide/globaltables_reqs_bestpractices.html<br>    JSON tfvars Example<br>    "global\_secondary\_index": {<br>        "name": "MyTable",<br>        "hash\_key": "Title"<br>        "range\_key": "Rating"<br>        "write\_capacity": 10<br>        "read\_capacity": 10<br>        "projection\_type": "INCLUDE"<br>        "non\_key\_attributes": ["Authors"] <br>    } | `map(any)` | `{}` | no |
| hash\_key | DynamoDB primary partition key | `string` | n/a | yes |
| name | Name of the DynamoDB Table | `string` | n/a | yes |
| point\_in\_time\_recovery | Allow Point in time recovery of backed up table, check https://docs.aws.amazon.com/amazondynamodb/latest/developerguide/PointInTimeRecovery.html | `bool` | `false` | no |
| range\_key | DynamoDB primary sort key | `string` | `null` | no |
| read\_capacity | Read Capacity Units (WCUs), check https://docs.aws.amazon.com/amazondynamodb/latest/developerguide/ProvisionedThroughput.html | `number` | `null` | no |
| replicas | AWS regions for Global DynamoDB Tables V2, check https://docs.aws.amazon.com/amazondynamodb/latest/developerguide/globaltables.V2.html | `list(string)` | `[]` | no |
| tags | Tags for the table.<br>    JSON tfvars Example<br>    "tags": {<br>        "Name": "MyTable",<br>        "ENVIRONEMNT": "DEV"<br>    } | `map(string)` | `{}` | no |
| write\_capacity | Write Capacity Units (WCUs), check https://calculator.aws/#/createCalculator/amazonDynamoDB | `number` | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| arn | The arn of the table |
| id | The name of the table |
| stream\_arn | The ARN of the Table Stream. Only available when stream\_enabled = true |
| stream\_label | A timestamp, in ISO 8601 format, for this stream. Note that this timestamp is not a unique identifier for the stream on its own. However, the combination of AWS customer ID, table name and this field is guaranteed to be unique. It can be used for creating CloudWatch Alarms. Only available when stream\_enabled = true |