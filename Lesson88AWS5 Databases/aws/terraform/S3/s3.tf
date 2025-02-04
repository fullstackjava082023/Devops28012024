resource "aws_s3_bucket" "random_bucket" { 
}

resource "aws_s3_bucket" "finance" { 
    bucket = "finance-bucket-arya-stark"
    tags = {
      Description = "Finance bucket for arya stark"
    }
}

resource "aws_s3_object" "finance_doc" {
   key = "finance.doc"
   content = "Hello, Arya Stark"
   bucket = aws_s3_bucket.finance.bucket
}

resource "aws_s3_object" "copy_file" {
  key = "images/table.jpg"
  source = "../../sync/table.jpg"
  bucket = aws_s3_bucket.finance.bucket
}

resource "aws_s3_bucket_public_access_block" "my_bucket_public_access" {
  bucket = aws_s3_bucket.finance.id
  block_public_acls       = false
  ignore_public_acls      = false
  block_public_policy     = false
  restrict_public_buckets = false
}


resource "aws_s3_bucket_policy" "public_bucket_policy" {
  bucket = aws_s3_bucket.finance.id
  policy = jsonencode({
                Version = "2012-10-17",
                Statement = [
                {
                    Effect    = "Allow",
                    Principal = "*",
                    Action    = "*",
                    Resource  = "arn:aws:s3:::${aws_s3_bucket.finance.id}/*"
                }
                ]
            })
}
