// ACM cert to attach to CF distro
resource "aws_acm_certificate" "cert" {
  domain_name       = "devhaughton.com"
  validation_method = "DNS"

  tags = {
    Environment = "test"
  }

  lifecycle {
    create_before_destroy = true
  }
}

// CloudFront origin access identity to associate with the distribution
resource "aws_cloudfront_origin_access_identity" "s3_origin_access_identity" {
  comment = "S3 OAI for the Cloudfront Distribution"
}

// CloudFront Distribution
resource "aws_cloudfront_distribution" "s3_distribution" {
  origin {
    domain_name = aws_s3_bucket.s3_site.bucket_regional_domain_name
    origin_id   = aws_s3_bucket.s3_site.id

    s3_origin_config {
      origin_access_identity = aws_cloudfront_origin_access_identity.s3_origin_access_identity.cloudfront_access_identity_path
    }
  }

  enabled             = true
  is_ipv6_enabled     = true
  comment             = "Cloudfront Distribution for S3 bucket"
  default_root_object = "index.html"

  default_cache_behavior {
    allowed_methods  = ["GET", "HEAD"]
    cached_methods   = ["GET", "HEAD"]
    target_origin_id = aws_s3_bucket.s3_site.id

    forwarded_values {
      query_string = false

      cookies {
        forward = "none"
      }
    }

    viewer_protocol_policy = "allow-all"
    min_ttl                = 0
    default_ttl            = 3600
    max_ttl                = 86400
  }

  price_class = "PriceClass_100"
  aliases     = ["devhaughton.com"]

  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }

  viewer_certificate {
    cloudfront_default_certificate = false
    acm_certificate_arn            = aws_acm_certificate.cert.arn
    ssl_support_method             = "sni-only"
    minimum_protocol_version       = "TLSv1"
  }

  depends_on = [
    aws_acm_certificate.cert
  ]
}


// Left off trying to figure out how to make a cert and add it to the CF distro. Because of validation it's kind of 
// scuffed. May need to create a cert in the console and then figure out how to reference it from here.