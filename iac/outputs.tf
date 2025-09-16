output "website_url" {
  value = aws_cloudfront_distribution.web_dist.domain_name
}

output "s3_bucket_name" {
  value = aws_s3_bucket.web.id
}

output "cloudfront_distribution_id" {
  value = aws_cloudfront_distribution.web_dist.id
}