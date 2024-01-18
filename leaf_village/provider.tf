terraform {
  required_version = ">= 0.13"
}
provider "aws" {
  region = local.region
}

terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 5.0, < 6.0"
    }
  }
}
