terraform {
  required_version = ">= 0.13"
  
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
}

provider "aws" {
  region = local.region
}

provider "aws" {
  region = "us-east-1"
  alias  = "cloudfront"
}
