resource "aws_cloudfront_distribution" "cloudfront_distribution" {
  aliases             = var.aliases
  default_root_object = var.default_root_object
  enabled             = var.enabled
  price_class         = var.price_class
  retain_on_delete    = var.retain_on_delete

  origin {
    domain_name              = var.domain_name
    origin_id                = var.origin_id
    origin_access_control_id = aws_cloudfront_origin_access_control.oac.id
  }

  restrictions {
    geo_restriction {
      restriction_type = var.restriction_type
      locations        = var.locations
    }
  }

  viewer_certificate {
    cloudfront_default_certificate = var.cloudfront_default_certificate
    acm_certificate_arn            = var.acm_certificate_arn
    ssl_support_method             = var.ssl_support_method
  }

  default_cache_behavior {
    allowed_methods  = var.allowed_methods
    cached_methods   = var.cached_methods
    cache_policy_id  = var.cache_policy_id
    target_origin_id = var.target_origin_id

    dynamic "forwarded_values" {
      for_each = var.cache_policy_id == null ? [1] : []
      content {
        query_string = var.query_string

        cookies {
          forward = var.forward
        }
      }
    }

    viewer_protocol_policy = var.viewer_protocol_policy
    default_ttl            = var.default_ttl
    min_ttl                = var.min_ttl
    max_ttl                = var.max_ttl
    
  }
}

resource "aws_cloudfront_origin_access_control" "oai" {
  name                              = "${var.teamname}-${var.oac_name}"
  description                       = var.oac_description
  origin_access_control_origin_type = var.origin_access_control_origin_type
  signing_behavior                  = var.signing_behavior
  signing_protocol                  = var.signing_protocol
}

