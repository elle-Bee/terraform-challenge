variable "subnet_name" {
  type        = string
  default     = ""
  description = "Name of subnet"
}

variable "vpc_id" {
  type        = string
  default     = ""
  description = "VPC ID"
}

variable "cidr_block" {
  type        = list(string)
  default     = []
  description = "description"
}

variable "vpc_cidr" {
  type        = string
  default     = ""
  description = "description"
}

variable "bits" {
  type        = number
  default     = null
  description = "description"
}

variable "netnum" {
  type        = number
  default     = null
  description = "description"
}

variable "subnet_ipv6_native" {
  type        = bool
  default     = false
  description = "(Optional) Indicates whether to create an IPv6-only subnet. "
}

variable "assign_ipv6_address_on_creation" {
  type        = bool
  default     = false
  description = "(Optional) Specify true to indicate that network interfaces created in the specified subnet should be assigned an IPv6 address. "
}

variable "region" {
  type        = string
  default     = ""
  description = "(Required) AWS region in which the subnet should be created."
}

variable "availability_zones" {
  type        = list(string)
  default     = []
  description = "(Required) List of avaialability zones"
}

variable "enable_dns64" {
  type        = bool
  default     = false
  description = "(Optional) Indicates whether DNS queries made to the Amazon-provided DNS Resolver in this subnet should return synthetic IPv6 addresses for IPv4-only destinations. "
}

variable "enable_resource_name_dns_aaaa_record_on_launch" {
  type        = bool
  default     = false
  description = "(Optional) Indicates whether to respond to DNS queries for instance hostnames with DNS AAAA records."
}

variable "enable_resource_name_dns_a_record_on_launch" {
  type        = bool
  default     = false
  description = "(Optional) Indicates whether to respond to DNS queries for instance hostnames with DNS A records. "
}

variable "ipv6_cidr_block" {
  type        = string
  default     = ""
  description = "Public Subnet CIDR blocks. The subnet size must use a /64 prefix length"
}

variable "map_public_ip_on_launch" {
  type        = bool
  default     = false
  description = "(Optional) Specify true to indicate that instances launched into the subnet should be assigned a public IP address."
}

variable "private_dns_hostname_type_on_launch" {
  type        = string
  default     = null
  description = "(Optional) The type of hostnames to assign to instances in the subnet at launch."
}

variable "subnet_tags" {
  description = "Tags for the Subnet"
  type        = map(string)
  default     = {}
}
