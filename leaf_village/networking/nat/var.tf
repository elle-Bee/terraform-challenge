variable "allocation_id" {
  type        = string
  default     = ""
  description = "(Optional) The Allocation ID of the Elastic IP address for the NAT Gateway. Required for connectivity_type of public"
}

variable "connectivity_type" {
  type        = string
  default     = "public"
  description = "(Optional) Connectivity type for the NAT Gateway. Valid values are private and public"
}

variable "private_ip" {
  type        = string
  default     = null
  description = "(Optional) The private IPv4 address to assign to the NAT Gateway explicitly."
}

variable "subnet_id" {
  type        = list(string)
  default     = {}
  description = "(Required) The Subnet ID of the subnet in which to place the NAT Gateway."
}

variable "secondary_allocation_ids" {
  type        = list(string)
  default     = []
  description = "(Optional) A list of secondary allocation EIP IDs for this NAT Gateway."
}

variable "secondary_private_ip_address_count" {
  type        = number
  default     = null
  description = "(Optional) [Private NAT Gateway only] The number of secondary private IPv4 addresses you want to assign to the NAT Gateway."
}

variable "secondary_private_ip_addresses" {
  type        = list(string)
  default     = []
  description = "(Optional) A list of secondary private IPv4 addresses to assign to the NAT Gateway"
}

variable "nat_tags" {
  description = "Tags for the NAT"
  type        = map(string)
  default     = {}
}

variable "nat_name" {
  type        = string
  default     = ""
  description = "Name of NAt"
}

variable "eip_name" {
  type        = string
  default     = ""
  description = "Name of EIP"
}

variable "eip_tags" {
  description = "Tags for the EIP"
  type        = map(string)
  default     = {}
}

variable "associate_with_private_ip" {
  type        = string
  default     = ""
  description = "(Optional) User-specified primary or secondary private IP address to associate with the Elastic IP address. "
}

variable "eip_domain" {
  type        = string
  default     = "vpc"
  description = "Indicates if this EIP is for use in VPC "
}

variable "network_border_group" {
  type        = string
  default     = null
  description = "(Optional) Location from which the IP address is advertised. "
}
