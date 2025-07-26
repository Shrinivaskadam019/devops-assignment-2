resource "aws_s3_bucket" "mybucket" {
  bucket = "shrinivas-devops-s3"
  acl    = "private"

  tags = {
    Name = "DevOpsAssignmentBucket"
  }

  lifecycle_rule {
    enabled = true

    expiration {
      days = 7
    }
  }
}

resource "aws_s3_bucket_public_access_block" "block" {
  bucket = aws_s3_bucket.mybucket.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}
