locals {
  region_mapping = {
    "senju"     = "us-east-1"
    "uchiha"    = "ap-south-1"
    "uzumaki"   = "us-east-2"
    "sarutobi"  = "us-west-1"
    "hyuga"     = "us-west-2"
    "hatake"    = "ap-southeast-1"
    "otsutsuki" = "ap-northeast-1"
  }

  matching_region = {
    for key, region in local.region_mapping :
    key => strcontains(var.teamname, key) ? region : null
  }
  region = join(",", [for region in values(local.matching_region) : region if region != null])
}

output "bucket" {
  value = local.region
}
