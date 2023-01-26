## s3 bucket with all public access blocked
resource "aws_s3_bucket" "OrgFiles" {
  bucket = "org-files-${var.stage}"
    acl    = "private"
    block_public_acls = true
}

## dynamodb table called OrgData with 16 global secondary indexes and on-demand billing
resource "aws_dynamodb_table" "OrgData" {
  name           = "OrgData-${var.stage}"
  billing_mode   = "PAY_PER_REQUEST"
  hash_key       = "PK"
  range_key      = "SK"
  attribute {
    name = "PK"
    type = "S"
  }
    attribute {
        name = "SK"
        type = "S"
    }
    attribute {
        name = "g1"
        type = "S"
    }
    attribute {
        name = "g2"
        type = "S"
    }
    attribute {
        name = "g3"
        type = "S"
    }
    attribute {
        name = "g4"
        type = "S"
    }
    attribute {
        name = "g5"
        type = "S"
    }
    attribute {
        name = "g6"
        type = "S"
    }
    attribute {
        name = "g7"
        type = "S"
    }
    attribute {
        name = "g8"
        type = "S"
    }
    attribute {
        name = "g9"
        type = "S"
    }
    attribute {
        name = "g10"
        type = "S"
    }
    attribute {
        name = "g11"
        type = "S"
    }
    attribute {
        name = "g12"
        type = "S"
    }
    attribute {
        name = "g13"
        type = "S"
    }
    attribute {
        name = "g14"
        type = "S"
    }
    attribute {
        name = "g15"
        type = "S"
    }
    attribute {
        name = "lu"
        type = "S"
    }
    global_secondary_index {
        name = "g1-index"
        hash_key = "PK"
        range_key = "g1"
        projection_type = "ALL"
    }
    global_secondary_index {
        name = "g2-index"
        hash_key = "PK"
        range_key = "g2"
        projection_type = "ALL"
    }
    global_secondary_index {
        name = "g3-index"
        hash_key = "PK"
        range_key = "g3"
        projection_type = "ALL"
    }
    global_secondary_index {
        name = "g4-index"
        hash_key = "PK"
        range_key = "g4"
        projection_type = "ALL"
    }
    global_secondary_index {
        name = "g5-index"
        hash_key = "PK"
        range_key = "g5"
        projection_type = "ALL"
    }
    global_secondary_index {
        name = "g6-index"
        hash_key = "PK"
        range_key = "g6"
        projection_type = "ALL"
    }
    global_secondary_index {
        name = "g7-index"
        hash_key = "PK"
        range_key = "g7"
        projection_type = "ALL"
    }
    global_secondary_index {
        name = "g8-index"
        hash_key = "PK"
        range_key = "g8"
        projection_type = "ALL"
    }
    global_secondary_index {
        name = "g9-index"
        hash_key = "PK"
        range_key = "g9"
        projection_type = "ALL"
    }
    global_secondary_index {
        name = "g10-index"
        hash_key = "PK"
        range_key = "g10"
        projection_type = "ALL"
    }
    global_secondary_index {
        name = "g11-index"
        hash_key = "PK"
        range_key = "g11"
        projection_type = "ALL"
    }
    global_secondary_index {
        name = "g12-index"
        hash_key = "PK"
        range_key = "g12"
        projection_type = "ALL"
    }
    global_secondary_index {
        name = "g13-index"
        hash_key = "PK"
        range_key = "g13"
        projection_type = "ALL"
    }
    global_secondary_index {
        name = "g14-index"
        hash_key = "PK"
        range_key = "g14"
        projection_type = "ALL"
    }
    global_secondary_index {
        name = "g15-index"
        hash_key = "PK"
        range_key = "g15"
        projection_type = "ALL"
    }
    global_secondary_index {
        name = "lu-index"
        hash_key = "PK"
        range_key = "lu"
        projection_type = "ALL"
    }
}



