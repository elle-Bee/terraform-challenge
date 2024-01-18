teamname     = "prakash-uchiha"
key          = "index.html"
content_type = "text/html"


ssl_support_method                = "sni-only"
oac_name                          = "Gameday"
oac_description                   = "gameday Policy"
origin_access_control_origin_type = "s3"
signing_behavior                  = "always"
signing_protocol                  = "sigv4"
default_root_object               = "index.html"
price_class                       = "PriceClass_All"
origin_id                         = "MyS3Origin"
allowed_methods                   = ["GET", "HEAD"]
cached_methods                    = ["GET", "HEAD"]
target_origin_id                  = "MyS3Origin"
viewer_protocol_policy            = "allow-all"
restriction_type                  = "blacklist"
locations                         = ["CA", "GB", "DE"]
cloudfront_default_certificate    = true
forward_query_string              = true
forward                           = "none"
enabled                           = true
retain_on_delete                  = false
hosted_zone_name = "opstree-war.live"
