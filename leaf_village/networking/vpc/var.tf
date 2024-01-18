variable "vpc_name" {
  description = "VPC Name"
  type        = string
  default     = null
}

variable "vpc_cidr_block" {
  description = "The IPv4 CIDR block for the VPC. Either `vpc_cidr_block` or `ipv4_primary_cidr_block_association` must be set, but not both."
  type        = string
  default     = null
}

variable "instance_tenancy" {
  description = "A tenancy option for instances launched into the VPC"
  type        = string
  default     = "default"
  validation {
    condition     = contains(["default", "dedicated"], var.instance_tenancy)
    error_message = "Instance tenancy must be one of \"default\" or \"dedicated\"."
  }
}

variable "enable_dns_support" {
  description = "Set `true` to enable DNS resolution in the VPC through the Amazon provided DNS server"
  type        = bool
  default     = true
}

variable "enable_dns_hostnames" {
  description = "Set `true` to enable dns-hostname in the VPC"
  type        = bool
  default     = false
}

variable "vpc_tags" {
  description = "Tags for the VPC"
  type        = map(string)
  default     = {}
}
variable "ipam_pool_enable" {
  type        = bool
  default     = false
  description = "Flag to be set true when using ipam for cidr."
}

variable "enable_network_address_usage_metrics" {
  type        = bool
  default     = false
  description = "(Optional) Indicates whether Network Address Usage metrics are enabled for your VPC. Defaults to false."
}

variable "assign_generated_ipv6_cidr_block" {
  type        = bool
  default     = false
  description = "Optional) Requests an Amazon-provided IPv6 CIDR block with a /56 prefix length for the VPC. When `true`, assign AWS generated IPv6 CIDR block to the VPC.  Conflicts with `ipv6_ipam_pool_id`."
}

variable "ipv6_primary_cidr_block_association" {
  type = object{
    ipv6_cidr_block     = string
    ipv6_ipam_pool_id   = string
    ipv6_netmask_length = number
  }
  description = <<-EOT
    Primary IPv6 CIDR block to assign to the VPC. Conflicts with `assign_generated_ipv6_cidr_block`.
    `ipv6_cidr_block` can be set explicitly, or set to `null` with the CIDR block derived from `ipv6_ipam_pool_id` using `ipv6_netmask_length`.
    EOT
  default     = null
}

variable "ipv4_primary_cidr_block_association" {
  type = object({
    ipv4_ipam_pool_id   = string
    ipv4_netmask_length = number
  })
  description = <<-EOT
    Configuration of the VPC's primary IPv4 CIDR block via IPAM. Conflicts with `vpc_cidr_block`.
    One of `vpc_cidr_block` or `ipv4_primary_cidr_block_association` must be set.
    Additional CIDR blocks can be set via `ipv4_additional_cidr_block_associations`.
    EOT
  default     = null
}

variable "ipv6_cidr_block_network_border_group" {
  type        = string
  default     = null
  description = "(Optional) By default when an IPv6 CIDR is assigned to a VPC a default ipv6_cidr_block_network_border_group will be set to the region of the VPC. This can be changed to restrict advertisement of public addresses to specific Network Border Groups such as LocalZones."
}