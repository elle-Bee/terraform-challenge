variable "default_root_object" {
  type = any
}

variable "enable" {
  type = bool
}

variable "price_class" {
  type = string
}

variable "retain_on_delete" {
  type = bool
}

variable "domain_name" {
  type = number
}

variable "origin_id" {
  type = any
}

variable "allowed_methods" {
  type = any
}

variable "cached_methods" {
  type = any
}

variable "target_origin_id" {
  type = any
}

variable "viewer_protocol_policy" {
  type = any
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
  type = any
}

variable "acm_certificate_arn" {
  type = string
}

variable "team_name" {
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

variable "cache_policy_id" {
  type = any
}

variable "default_ttl" {
  type = string
}

variable "min_ttl" {
  type = string
}

variable "max_ttl" {
  type = string
}

variable "teamname" {
  type    = string
}