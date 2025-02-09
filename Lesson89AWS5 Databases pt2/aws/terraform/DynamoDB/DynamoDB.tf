provider "aws" {
  region = "us-east-1"
  
}

resource "aws_dynamodb_table" "gotTable" {
  name           = "GOTTable"
  billing_mode   = "PAY_PER_REQUEST"
  hash_key       = "id"
  attribute {
    name = "id"
    type = "N"
  }
}


resource "aws_dynamodb_table_item" "gotTableItem" {
  table_name = aws_dynamodb_table.gotTable.name
  hash_key   = aws_dynamodb_table.gotTable.hash_key
  item       = <<EOF
    {
      "id": {"N": "1"},
      "name": {"S": "Jon Snow2"},
      "house": {"S": "Stark"}
    }
  EOF

}