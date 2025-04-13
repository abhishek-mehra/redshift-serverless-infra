resource "aws_kms_key" "redshift_kms"{
    description  = "KMS key for aws redshift"
    enable_key_rotation = false
    deletion_window_in_days = 20
}

resource "aws_kms_key_policy" "redshift_kms_policy" {
    key_id = aws_kms_key.redshift_kms.id

    policy = <<EOF
{
    "Version": "2012-10-17",
    "Id": "key-default-1",
    "Statement": [
        {
            "Sid": "AllowRootAccountFullAccess",
            "Effect": "Allow",
            "Principal": {
                "AWS": "arn:aws:iam::${data.aws_caller_identity.current.account_id}:root"
            },
            "Action": "kms:*",
            "Resource": "*"
        }
    ]
}
EOF
}

resource "aws_kms_alias" "redshift_alias"{
    name = "alias/redshift-key"
    target_key_id = aws_kms_key.redshift_kms.id
}

data "aws_caller_identity" "current" {}