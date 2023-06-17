module "records" {
  source  = "terraform-aws-modules/route53/aws//modules/records"
  version = "~> 2.0"

  zone_id = data.aws_route53_zone.zone.zone_id

  records = [
    {
      name    = ""
      type    = "A"
      alias   = {
        name    = module.cdn.cloudfront_distribution_domain_name
        zone_id = module.cdn.cloudfront_distribution_hosted_zone_id
      }
    },
    {
      name    = "www"
      type    = "CNAME"
      ttl = "60"
      records = [
        var.domain_name,
      ]
    },    
  ]

}