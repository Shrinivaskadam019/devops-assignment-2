output "bucket_name" {
  value = aws_s3_bucket.mybucket.id
}

output "role_a_arn" {
  value = aws_iam_role.role_a.arn
}

output "role_b_arn" {
  value = aws_iam_role.role_b.arn
}
