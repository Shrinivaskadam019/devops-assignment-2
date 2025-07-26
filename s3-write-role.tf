resource "aws_iam_role" "role_b" {
  name = "RoleB_UploadOnlyS3"
  assume_role_policy = data.aws_iam_policy_document.assume_role_b.json
}

data "aws_iam_policy_document" "assume_role_b" {
  statement {
    actions = ["sts:AssumeRole"]
    principals {
      type        = "Service"
      identifiers = ["ec2.amazonaws.com"]
    }
  }
}

resource "aws_iam_policy" "upload_policy" {
  name   = "UploadOnlyPolicy"
  policy = data.aws_iam_policy_document.upload_only_policy.json
}

data "aws_iam_policy_document" "upload_only_policy" {
  statement {
    actions   = ["s3:PutObject"]
    resources = ["${aws_s3_bucket.mybucket.arn}/*"]
  }
}

resource "aws_iam_role_policy_attachment" "role_b_attach" {
  role       = aws_iam_role.role_b.name
  policy_arn = aws_iam_policy.upload_policy.arn
}

resource "aws_iam_instance_profile" "role_b_profile" {
  name = "RoleBInstanceProfile"
  role = aws_iam_role.role_b.name
}
