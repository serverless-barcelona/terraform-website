data "aws_route53_zone" "zone" {
  name         = var.domain_name
}
module "acm" {
  providers = {
    aws = aws.use1
  }
  source  = "terraform-aws-modules/acm/aws"
  version = "~> 4.0"

  domain_name  = var.domain_name
  zone_id      = data.aws_route53_zone.zone.zone_id

  subject_alternative_names = [
    "www.${var.domain_name}"
  ]

  wait_for_validation = true

}
