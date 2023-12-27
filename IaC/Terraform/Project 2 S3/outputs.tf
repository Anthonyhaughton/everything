output "bucket_name" {
  value       = aws_s3_bucket.s3_site.bucket
  description = "The name of the bucket"
}

output "bucket_arn" {
  value       = aws_s3_bucket.s3_site.arn
  description = "The ARN of the bucket"
}

output "cloudfront_domain_name" {
  description = "The domain name corresponding to the distribution"
  value       = aws_cloudfront_distribution.s3_distribution.domain_name
}
