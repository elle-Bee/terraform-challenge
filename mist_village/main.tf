resource "random_pet" "name" {
  length    = 2
  separator = "-"
}

module "bucket" {
  source          = "./s3_bucket"
  s3_bucket_names = "ot-${var.teamname}-${random_pet.name.id}"
  key             = var.key
  content_type    = var.content_type
  content         = data.template_file.index_html.rendered
}

data "template_file" "index_html" {
  template = file("index.html")
  vars = {
    teamname = var.teamname
  }
}

module "cdn" {
  source                            = "./cloudfront"
  default_root_object               = var.default_root_object
  enabled                           = var.enabled
  price_class                       = var.price_class
  retain_on_delete                  = var.retain_on_delete
  domain_name                       = module.bucket.website
  origin_id                         = var.origin_id
  allowed_methods                   = var.allowed_methods
  cached_methods                    = var.cached_methods
  target_origin_id                  = var.target_origin_id
  viewer_protocol_policy            = var.viewer_protocol_policy
  restriction_type                  = var.restriction_type
  locations                         = var.location
  cloudfront_default_certificate    = var.cloudfront_default_certificate
  acm_certificate_arn               = data.aws_acm_certificate.cert.arn
  forward_query_string              = var.forward_query_string
  forward                           = var.forward_cache
  team_name                         = var.teamname
  ssl_support_method                = var.ssl_support_method
  oac_name                          = var.oac_name
  oac_description                   = var.oac_description
  origin_access_control_origin_type = var.origin_access_control_origin_type
  signing_behavior                  = var.signing_behavior
  signing_protocol                  = var.signing_protocol
  aliases                           = ["${var.teamname}-mist.opstree-war.live"]
  default_ttl                       = var.default_ttl
  min_ttl                           = var.min_ttl
  max_ttl                           = var.max_ttl
  cache_policy_id                   = var.cache_policy_id
  team_name                          = var.teamname
}

module "bucket_policy" {
  source         = "s3_bucket_policy"
  S3_name        = module.bucket.S3_name
  cloudfront_arn = module.cdn.cloudfront_arn
  s3_bucket_arn  = module.bucket.bucket_arn
}

module "route53_zone" {
  source = "git::https://github.com/OT-CLOUD-KIT/terraform-aws-route53-record-mapping.git?ref=route53"
  route53_record = {
    "${var.teamname}-mist.opstree-war.live" = {
      hosted_zone_name = var.hosted_zone_name
      zone_id          = data.aws_route53_zone.hostedzone.id
      type             = "A"
      ttl              = null
      alias = [{
        name                   = module.cloudfront.cloudfront_domain
        zone_id                = module.cloudfront.cloudfront_zone
        evaluate_target_health = true
      }]
    }
  }
}


