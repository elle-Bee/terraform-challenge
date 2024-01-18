
variable "hosted_zone_name" {
  type    = string
  default = "opstree-war.live"
}

variable "teamname" {
  type    = string
  default = "avengers"
}

variable "key" {
  type = string
}

variable "content_type" {
  type = string
}

variable "ssl_support_method" {
  type = string
}

variable "oac_name" {
  type = string
}

variable "oac_description" {
  type = string
}

variable "origin_access_control_origin_type" {
  type = string
}

variable "signing_behavior" {
  type = string
}

variable "signing_protocol" {
  type = string
}

variable "default_root_object" {
  type = string
}

variable "price_class" {
  type = string
}

variable "origin_id" {
  type = string
}

variable "allowed_methods" {
  type = any
}

variable "cached_methods" {
  type = any
}

variable "target_origin_id" {
  type = string
}

variable "viewer_protocol_policy" {
  type = string
}

variable "restriction_type" {
  type = string
}

variable "locations" {
  type = any
}

variable "cloudfront_default_certificate" {
  type = bool
}

variable "forward_query_string" {
  type = any
}

variable "forward" {
  type = string
}

variable "enabled" {
  type = bool
}

variable "retain_on_delete" {
  type = bool
}

# variable "aliases" {
#   type = any
# }


variable "tags" {
  type = map(string)
  default = {
    Environment = "production"
  }
}

variable "cache_policy_id" {
  type        = string
  default     = null
  description = <<-EOT
    The unique identifier of the existing cache policy to attach to the default cache behavior.
    If not provided, this module will add a default cache policy using other provided inputs.
    EOT
}

variable "default_ttl" {
  type        = bool
}

variable "min_ttl" {
  type        = number
  default     = 0
  description = "Minimum amount of time that you want objects to stay in CloudFront caches"
}

variable "max_ttl" {
  type        = number
  default     = 31536000
  description = "Maximum amount of time (in seconds) that an object is in a CloudFront cache"
}