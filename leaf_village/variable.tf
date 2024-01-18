variable "vpc_cidr_block" {
  description = "The IPv4 CIDR block for the VPC. Either `vpc_cidr_block` or `ipv4_primary_cidr_block_association` must be set, but not both."
  type        = string
  default     = "10.0.0.0/16"
}

variable "vpc_name" {
  description = "VPC Name"
  type        = string
  default     = "tf-vpc"
}

variable "tags" {
  description = "Tags for the VPC"
  type        = map(string)
  default = {
    env = "test"
  }
}

variable "enable_public_web_security_group_resource" {
  type        = bool
  default     = true
  description = "description"
}

variable "public_web_sg_name" {
  type        = string
  default     = "tf-sg-alb"
  description = "description"
}

variable "key_name" {
  type        = string
  default     = "tf-test-key"
  description = "description"
}

variable "enable_pub_alb_resource" {
  type        = bool
  default     = true
  description = "description"
}

variable "alb_name" {
  description = "Name of ALB"
  type        = string
  default     = "tf-test-alb"
}

variable "alb_type" {
  type        = bool
  default     = false
  description = "description"
}

variable "enable_alb_logging" {
  type    = bool
  default = false
}

variable "enable_deletion_protection" {
  type    = bool
  default = false
}

variable "route53_zone" {
  type = map(object({
    comment           = optional(string)
    delegation_set_id = optional(string)
    tags              = optional(map(string))
    force_destroy     = optional(bool, false)
    private_zone = optional(map(object({
      vpc_id     = string
      vpc_region = string
    })))
  }))
  default = {
    "opstree-war.live" = {
      comment       = "example public hosted zone"
      force_destroy = true
      tags = {
        ManagedBy = "Terraform"
        Name      = "Example"
        Type      = "Public"
      }
    }
  }
}

variable "route53_record" {
  type = map(object({
    record_name      = optional(string)
    type             = string
    ttl              = number
    hosted_zone_name = optional(string)
    records          = optional(list(string))
    alias = optional(list(object({
      name                   = string
      zone_id                = string
      evaluate_target_health = bool
    })))
  }))
  default     = null
  description = "Route53 records for a specific hosted zone"

}


variable "team_name" {
  description = "Team Name"
  type        = string
  default     = "marvel"
}

variable "instance_type" {
  type        = string
  default     = "t2.micro"
  description = "Instance type"
}

variable "resource_type" {
  type        = string
  default     = "instance"
  description = "resource type"
}

variable max_size {
  type        = number
  default     = 2
  description = "Max size for asg"
}

variable desired_size {
  type        = number
  default     = 2
  description = "Desired size for asg"
}

variable "availability_zones" {
  type        = list(string)
  default     = "a", "b"
  description = "In which availability zones resource should be deployed"
}

variable "public_subnet_cidr" {
  type        = list(string)
  default     = ["10.0.1.0/24", "10.0.2.0/24"]
  description = "CIDR for public subnets"
}

variable "private_subnet_cidr" {
  type        = list(string)
  default     = ["10.0.3.0/24", "10.0.4.0/24"]
  description = "CIDR for private subnets"
}

variable "hosted_zone_name" {
  type        = string
  default     = "opstree-war.live"
  description = "Route53 hosted zone name"
}

variable "route53_record_type" {
  type        = string
  default     = "A"
}