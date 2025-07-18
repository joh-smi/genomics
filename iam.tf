resource "aws_iam_user" "user_a" {
  name = "UserA"
}

resource "aws_iam_user" "user_b" {
  name = "UserB"
}

resource "aws_iam_policy" "user_a_policy" {
  name = "UserA_S3_Access"
  policy = jsonencode({
    Version = "2012-10-17",
    Statement: [{
      Effect: "Allow",
      Action: ["s3:GetObject", "s3:PutObject"],
      Resource: "${aws_s3_bucket.bucket_a.arn}/*"
    }]
  })
}

resource "aws_iam_policy" "user_b_policy" {
  name = "UserB_S3_ReadOnly"
  policy = jsonencode({
    Version = "2012-10-17",
    Statement: [{
      Effect: "Allow",
      Action: ["s3:GetObject"],
      Resource: "${aws_s3_bucket.bucket_b.arn}/*"
    }]
  })
}

resource "aws_iam_user_policy_attachment" "user_a_attach" {
  user       = aws_iam_user.user_a.name
  policy_arn = aws_iam_policy.user_a_policy.arn
}

resource "aws_iam_user_policy_attachment" "user_b_attach" {
  user       = aws_iam_user.user_b.name
  policy_arn = aws_iam_policy.user_b_policy.arn
}

