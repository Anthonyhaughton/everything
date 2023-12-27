# using the data block to tap into AWS to use the existing zone
data "aws_route53_zone" "primary" {
  name         = var.dns_name
  private_zone = false
}

resource "aws_route53_record" "www" {
  zone_id = data.aws_route53_zone.primary.zone_id
  name    = var.dns_name
  type    = "A"

  alias {
    name                     = aws_cloudfront_distribution.s3_distribution.domain_name
    zone_id                  = aws_cloudfront_distribution.s3_distribution.hosted_zone_id
    evaluate_target_health   = false
  }


}