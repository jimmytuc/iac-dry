resource "aws_s3_bucket" "site" {
  bucket = var.bucket

  website {
    index_document = "index.html"
    error_document = "/404.html"
  }
}

resource "aws_s3_bucket_website_configuration" "site" {
  bucket = aws_s3_bucket.site.bucket

  index_document {
    suffix = "index.html"
  }

  error_document {
    key = "/404.html"
  }
}

resource "aws_s3_bucket_acl" "site" {
  bucket = aws_s3_bucket.site.id

  acl = "private"
}

resource "aws_s3_bucket_policy" "site" {
  bucket = aws_s3_bucket.site.id

  policy = data.aws_iam_policy_document.bucket_policy.json
}

data "aws_iam_policy_document" "bucket_policy" {
  statement {
    sid = "AllowedIPReadAccess"

    actions = [
      "s3:GetObject",
    ]

    resources = [
      "arn:aws:s3:::${var.bucket}/*",
    ]

    condition {
      test     = "IpAddress"
      variable = "aws:SourceIp"

      values = ["0.0.0.0/0"]
    }

    principals {
      type        = "*"
      identifiers = ["*"]
    }

    # principals {
    #   type        = "AWS"
    #   identifiers = [aws_cloudfront_origin_access_identity.origin_access_identity.iam_arn]
    # }
  }
}
