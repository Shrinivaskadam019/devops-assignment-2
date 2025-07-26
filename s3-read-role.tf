resource "aws_iam_role" "role_a" {
  name = "RoleA_ReadOnlyS3"
  assume_role_policy = data.aws_iam_policy_document.assume_role_a.json
}

data "aws_iam_policy_document" "assume_role_a" {
  statement {
    actions = ["sts:AssumeRole"]
    principals {
      type        = "Service"
      identifiers = ["ec2.amazonaws.com"]
    }
  }
}

resource "aws_iam_policy" "read_policy" {
  name   = "ReadOnlyPolicy"
  policy = data.aws_iam_policy_document.read_only_policy.json
}

data "aws_iam_policy_document" "read_only_policy" {
  statement {
    actions   = ["s3:GetObject", "s3:ListBucket"]
    resources = ["${aws_s3_bucket.mybucket.arn}", "${aws_s3_bucket.mybucket.arn}/*"]
  }
}

resource "aws_iam_role_policy_attachment" "role_a_attach" {
  role       = aws_iam_role.role_a.name
  policy_arn = aws_iam_policy.read_policy.arn
}

resource "aws_iam_instance_profile" "role_a_profile" {
  name = "RoleAInstanceProfile"
  role = aws_iam_role.role_a.name
}
