data "terraform_remote_state" "admin" {
  backend = "local"

  config = {
    path = "../vaults/terraform.tfstate"
  }
}


data "vault_aws_access_credentials" "creds" {
  backend = data.terraform_remote_state.admin.outputs.backend
  role    = data.terraform_remote_state.admin.outputs.role
  region  = var.region
}


resource "aws_dynamodb_table" "example" {
  name           = "your_table_name"
  billing_mode   = "PROVISIONED"
  read_capacity  = 5
  write_capacity = 5

  attribute {
    name = "id"
    type = "S"
  }

  key_schema {
    attribute_name = "id"
    key_type       = "HASH"
  }
}


resource "aws_dynamodb_table_item" "example" {
  table_name = aws_dynamodb_table.example.name
  hash_key   = aws_dynamodb_table.example.hash_key

  item = <<ITEM
{
  "exampleHashKey": {"S": "something"},
  "one": {"N": "11111"},
  "two": {"N": "22222"},
  "three": {"N": "33333"},
  "four": {"N": "44444"}
}
ITEM
}
