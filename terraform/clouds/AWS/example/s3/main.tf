provider "aws" {
  profile = "endava"
  shared_credentials_file = "/home/vcafarschi/.aws/credentials"
  region = "us-east-2"
}

data "aws_iam_role" "iam" {
  name = "ec2-s3"
}

################################################################################
# KMS-key for S3
################################################################################
resource "aws_kms_key" "mykey" {
  description             = "This key is used to encrypt bucket objects"
  deletion_window_in_days = 20

  policy      = <<EOF
{
    "Version": "2012-10-17",
    "Id": "key-default-1",
    "Statement": [
        {
            "Sid": "Enable IAM User Permissions",
            "Effect": "Allow",
            "Principal": {
                "AWS": [
                    "arn:aws:iam::315727832121:root",
                    "${data.aws_iam_role.iam.arn}"
                ]
            },
            "Action": "kms:*",
            "Resource": "*"
        }
    ]
}
EOF

  tags = merge(
    var.default_tags,
    { "Name" = "vcafarschi-kms-key-for-bucket" }
  )
}

################################################################################
# KMS-key alias
################################################################################
resource "aws_kms_alias" "alias" {
  name          = "alias/vcafarschi-kms-key-for-bucket"
  target_key_id = aws_kms_key.mykey.key_id
}

################################################################################
# S3 bucket
################################################################################
resource "aws_s3_bucket" "terraform_state" {
  bucket = "vcafarschi-uploads"

  versioning {
    enabled = true
  }

  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        kms_master_key_id = aws_kms_key.mykey.arn
        sse_algorithm     = "aws:kms"
      }
    }
  }

  lifecycle {
    prevent_destroy = true
  }
}
