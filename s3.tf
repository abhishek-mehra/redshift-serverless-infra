# Create the S3 bucket
resource "aws_s3_bucket" "secure_data_lake" {
  bucket = "redshift-secure-data-lake-${data.aws_caller_identity.current.account_id}"

  tags = {
    Name        = "Redshift Data Lake"
    Environment = "dev"
  }
}

resource "aws_s3_bucket_server_side_encryption_configuration" "sse_s3"{
    bucket = aws_s3_bucket.secure_data_lake.id


    rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"  # <- SSE-S3 encryption
    }
  }
}

resource "aws_s3_bucket_public_access_block" "block_public" {
  bucket = aws_s3_bucket.secure_data_lake.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}
