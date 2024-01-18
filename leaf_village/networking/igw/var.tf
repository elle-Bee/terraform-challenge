variable "vpc_id" {
  type        = string
  description = "The VPC ID to create in"
  default     = null
}
variable "igw_tags" {
  type        = map(string)
  description = "A map of tags to assign to the igw"
  default     = {}
}

variable "igw_name" {
  type        = string
  default     = ""
  description = "IGW name"
}
