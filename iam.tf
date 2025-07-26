resource "aws_iam_role" "role_a" {
  name = "RoleA_ReadOnlyS3"

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [{
      Action    = "sts:AssumeRole",
      Effect    = "Allow",
      Principal = {
        Service = "ec2.amazonaws.com"
      }
    }]
  })
}

resource "aws_iam_role_policy_attachment" "role_a_attach" {
  role       = aws_iam_role.role_a.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonS3ReadOnlyAccess"
}

resource "aws_iam_role" "role_b" {
  name = "RoleB_UploadOnlyS3"

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [{
      Action    = "sts:AssumeRole",
      Effect    = "Allow",
      Principal = {
        Service = "ec2.amazonaws.com"
      }
    }]
  })
}

resource "aws_iam_policy" "upload_policy" {
  name        = "UploadOnlyPolicy"
  description = "Allow only PutObject to specific bucket"

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [{
      Effect   = "Allow",
      Action   = "s3:PutObject",
      Resource = "arn:aws:s3:::shrinivas-devops-s3/*"
    }]
  })
}

resource "aws_iam_role_policy_attachment" "role_b_attach" {
  role       = aws_iam_role.role_b.name
  policy_arn = aws_iam_policy.upload_policy.arn
}

resource "aws_iam_instance_profile" "role_b_profile" {
  name = "RoleBInstanceProfile"
  role = aws_iam_role.role_b.name
}
