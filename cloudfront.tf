module "cdn" {
  source = "terraform-aws-modules/cloudfront/aws"

  aliases = [var.domain_name,"www.${var.domain_name}"]

  comment             = "Website CDN"
  enabled             = true
  is_ipv6_enabled     = false
  price_class         = "PriceClass_100"
  retain_on_delete    = false
  wait_for_deployment = false

  create_origin_access_control = true
  origin_access_control = {
    s3 = {
      description = "My awesome CloudFront can access"
      origin_type = "s3"
      signing_behavior = "always"
      signing_protocol = "sigv4"
    }
  }

  # logging_config = {
  #   bucket = "logs-my-cdn.s3.amazonaws.com"
  # }

  origin = {
    s3 = {
      domain_name = module.s3.s3_bucket_bucket_domain_name
      origin_access_control = "s3"
    }
  }

  default_cache_behavior = {
    target_origin_id           = "s3"
    viewer_protocol_policy     = "allow-all"

    allowed_methods = ["GET", "HEAD", "OPTIONS"]
    cached_methods  = ["GET", "HEAD"]
    compress        = true
    query_string    = true
  }

  viewer_certificate = {
    acm_certificate_arn = module.acm.acm_certificate_arn
    ssl_support_method  = "sni-only"
  }
}
