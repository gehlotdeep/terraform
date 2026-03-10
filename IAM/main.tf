resource "aws_iam_group_membership" "DevOps_Team" {
  name = "tf-testing-group-membership"

  users = [
    aws_iam_user.user_one.name,
  ]

  group = aws_iam_group.group.name
}

resource "aws_iam_group" "group" {
  name = "DevOps-Group"
}

resource "aws_iam_user" "user_one" {
  name = "deepak"
  tags = {
    name = "my-tag"
 }
}

resource "aws_iam_role" "dev_role" {
  name = "test_role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Effect = "Allow"
      Principal = {
        Service = "ec2.amazonaws.com"
      }
      Action = "sts:AssumeRole"
    }]
  })

  tags = {
    tag-key = "tag-value"
  }
}

resource "aws_iam_policy" "policy" {
  name = "custom-ec2-policy"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Effect   = "Allow"
      Action   = ["ec2:DescribeInstances"]
      Resource = "*"
    }]
  })
}


resource "aws_iam_role_policy_attachment" "s3_full_access" {
  role       = aws_iam_role.dev_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonS3FullAccess"
}

resource "aws_iam_role_policy_attachment" "ec2_Read_only_access"{
  role       = aws_iam_role.dev_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ReadOnlyAccess"
}

resource "aws_iam_user_policy_attachment" "user_ec2_policy" {
  user       = aws_iam_user.user_one.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2FullAccess"  
}

resource "aws_iam_user_policy_attachment" "user_policy" {
  user       = aws_iam_user.user_one.name
  policy_arn = aws_iam_policy.policy.arn
}

