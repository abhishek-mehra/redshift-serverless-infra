resource "aws_iam_role" "glue_job_role" {
  name = "glue-job-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Principal = {
          Service = "glue.amazonaws.com"
        },
        Action = "sts:AssumeRole"
      }
    ]
  })

  tags = {
    Purpose = "Glue ETL Job Role"
  }
}

resource "aws_iam_policy" "glue_s3_access" {
  name        = "GlueS3AccessPolicy"
  description = "Allow Glue to read from S3 bucket"
  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Sid: "AllowS3ReadAccess",
        Effect: "Allow",
        Action: [
          "s3:GetObject",
          "s3:ListBucket"
        ],
        Resource: [
          aws_s3_bucket.secure_data_lake.arn,
          "${aws_s3_bucket.secure_data_lake.arn}/*"
        ]
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "attach_s3_policy" {
  role       = aws_iam_role.glue_job_role.name
  policy_arn = aws_iam_policy.glue_s3_access.arn
}
