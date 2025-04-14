resource "aws_iam_role" "redshift_admin_role" {
  name = "redshift-admin-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [{
      Effect = "Allow",
      Principal = {
        Service = "redshift.amazonaws.com"
      },
      Action = "sts:AssumeRole"
    }]
  })

  tags = {
    Purpose = "Redshift Namespace Admin Role"
  }
}

resource "aws_iam_role_policy_attachment" "redshift_commands_policy" {
  role       = aws_iam_role.redshift_admin_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonRedshiftAllCommandsFullAccess"
}
