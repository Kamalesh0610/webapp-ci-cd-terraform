provider "aws" {
  region = var.aws_region
}

resource "random_id" "suffix" {
  byte_length = 4
}

resource "aws_s3_bucket" "web" {
  bucket = "devops-demo-webapp-${random_id.suffix.hex}"
}

resource "aws_s3_bucket_public_access_block" "web" {
  bucket                  = aws_s3_bucket.web.id
  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}

resource "aws_s3_bucket_website_configuration" "web" {
  bucket = aws_s3_bucket.web.id

  index_document {
    suffix = "index.html"
  }

  error_document {
    key = "index.html"
  }
}

resource "aws_s3_bucket_policy" "web_policy" {
  bucket = aws_s3_bucket.web.id
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Effect = "Allow"
      Principal = "*"
      Action = "s3:GetObject"
      Resource = "${aws_s3_bucket.web.arn}/*"
    }]
  })
  depends_on = [aws_s3_bucket_public_access_block.web]
}

resource "aws_cloudfront_distribution" "web_dist" {
  origin {
    domain_name = aws_s3_bucket.web.bucket_regional_domain_name
    origin_id   = "s3-web-origin"

    s3_origin_config {
      origin_access_identity = ""
    }
  }
  enabled             = true
  default_root_object = "index.html"
  default_cache_behavior {
    allowed_methods        = ["GET", "HEAD"]
    cached_methods         = ["GET", "HEAD"]
    target_origin_id       = "s3-web-origin"
    viewer_protocol_policy = "redirect-to-https"
    forwarded_values {
      query_string = false
      cookies {
        forward = "none"
      }
    }
  }
  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }
  viewer_certificate {
    cloudfront_default_certificate = true
  }
}