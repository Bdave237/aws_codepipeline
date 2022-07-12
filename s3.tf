

resource "aws_kms_key" "mykey" {
  description             = "This key is used to encrypt bucket objects"
  deletion_window_in_days = var.deletion_window_in_days
}

resource "aws_s3_bucket" "mybucket" {
  bucket = var.bucket
  
}

resource "aws_s3_bucket_acl" "mybucket" {
    bucket = aws_s3_bucket.mybucket.id
    acl = var.acl
}

resource "aws_s3_bucket_server_side_encryption_configuration" "mybucket" {
  bucket = aws_s3_bucket.mybucket.bucket

  rule {
    apply_server_side_encryption_by_default {
      kms_master_key_id = aws_kms_key.mykey.arn
      sse_algorithm     = "aws:kms"
    }
  }
}

resource "aws_s3_bucket_policy" "allow_ssl_tls_requests_only" {
  bucket = aws_s3_bucket.mybucket.id
  policy = <<POLICY
  {
    "Id": "ExamplePolicy",
    "Version": "2012-10-17",
    "Statement": [
        {
        "Sid": "AllowSSLRequestsOnly",
        "Action": "s3:*",
        "Effect": "Deny",
        "Resource": [
            "arn:aws:s3:::test_VA_bucket/*"
        ],
        "Condition": {
            "Bool": {
            "aws:SecureTransport": "false"
            }
        },
        "Principal": "*"
        }
    ]
    }
    POLICY
}