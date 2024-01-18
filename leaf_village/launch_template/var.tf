variable "lt_name" {
  type        = string
  default     = ""
  description = "(Optional) The name of the launch template."
}

variable "cpu_credits" {
  type        = string
  default     = "standard"
  description = "The credit option for CPU usage. Can be standard or unlimited"
}

variable "ebs_optimized" {
  type        = bool
  default     = null
  description = "(Optional) If true, the launched EC2 instance will be EBS-optimized."
}

variable "ram_disk_id" {
  type        = string
  default     = ""
  description = " (Optional) The ID of the RAM disk."
}

variable "elastic_gpu_specifications" {
  type        = any
  default     = {}
  description = "(Optional) The elastic GPU type to attach to the instance. "
}

variable "block_device_mappings" {
  type = list(object({
    device_name = string
    ebs = optional(object({
      volume_size           = optional()
      delete_on_termination = optional(bool)
      encrypted             = optional(bool)
      iops                  = optional(number)
      kms_key_id            = optional(string)
      snapshot_id           = optional(string)
      throughput            = optional(number)
      volume_type           = optional(string)
    }))
    no_device    = optional(bool)
    virtual_name = optional(string)
  }))
  default = []
}

variable "capacity_reservation_specification" {
  type = list(object({
    capacity_reservation_preference = optional(string, "none")
    capacity_reservation_target = optional(object({
      capacity_reservation_id                 = string
      capacity_reservation_resource_group_arn = string
    }))
  }))
  default = []
  description = "description"
}

variable "metadata_options_block" {
  type = list(object({
    http_endpoint               = optional(string, "enabled")
    http_tokens                 = optional(string, "optional")
    http_put_response_hop_limit = optional(number, 1)
    http_protocol_ipv6          = optional(string, "disabled")
    instance_metadata_tags      = optional(string, "disabled")
  }))
  default = []
  description = "description"
}


variable "maintenance_options" {
  type        = any
  default     = {}
  description = "(Optional) Disables the automatic recovery behavior of your instance or sets it to default. Can be default or disabled"
}

variable "placement_values" {
  type = map(string)
}

variable "instance_initiated_shutdown_behavior" {
  type        = string
  default     = "stop"
  description = " (Optional) Shutdown behavior for the instance. Can be stop or terminate"
}

variable "disable_api_termination" {
  type        = bool
  default     = null
  description = "(Optional) If true, enables EC2 Instance Termination Protection"
}

variable "disable_api_stop" {
  type        = bool
  default     = null
  description = "(Optional) If true, enables EC2 Instance Stop Protection."
}

variable "image_id" {
  type        = string
  default     = ""
  description = "(Optional) The AMI from which to launch the instance"
}

variable "instance_type" {
  type        = string
  default     = "t2.micro"
  description = "(Optional) The type of the instance. If present then instance_requirements cannot be present."
}

variable "kernel_id" {
  type        = string
  default     = ""
  description = "(Optional) The kernel ID."
}

variable "key_name" {
  type        = string
  default     = ""
  description = "(Optional) The key name to use for the instance."
}

variable "private_dns_name_options" {
  type = list(object({
    enable_resource_name_dns_aaaa_record = optional(bool, false)
    enable_resource_name_dns_a_record    = optional(bool, false)
    hostname_type                        = optional(string)
  }))
  default = []
  validation {
    condition     = var.private_dns_name_options != null && alltrue([for opt in var.private_dns_name_options : opt.hostname_type != null &&  can(regex("^(ip-name|resource-name)$", opt.hostname_type))])
    error_message = "Invalid 'hostname_type'. Must be either 'ip-name' or 'resource-name'."
  }
}

variable "instance_market_options" {
  description = "The market (purchasing) option for the instance"
  type        = list(object({
    market_type = optional(string, "spot")
    spot_options = object({
      block_duration_minutes            = optional(number)
      instance_interruption_behavior    = optional(string, "terminate")
      max_price                         = optional(string)
      spot_instance_type                = optional(string)
      valid_until                       = optional(string)
    })
  }))
  default     = []
}

variable "security_groups" {
  type        = list(string)
  default     = []
  description = "(Optional) A list of security group IDs to associate with. "
}

variable "default_version" {
  type        = number
  default     = null
  description = "(Optional) Default Version of the launch template."
}

variable "update_default_version" {
  type        = bool
  default     = false
  description = "(Optional) Whether to update Default Version each update. "
}

variable "cpu_options" {
  type = map(object({
    amd_sev_snp      = optional(string)
    core_count       = optional(number, 4)
    threads_per_core = optional(number, 2)
  }))  
  default = null
}

variable "license_configuration" {
  type        = map(string)
  default     = {}
  description = "description"
}

variable "user_data" {
  type        = string
  default     = null
  description = "description"
}

variable "launch_template_description" {
  description = "Description of the launch template"
  type        = string
  default     = null
}

variable "enable_monitoring" {
  description = "Enables/disables detailed monitoring"
  type        = bool
  default     = true
}

variable "network_interfaces" {
  type        = any
  default     = {}
  description = "description"
}

variable "tag_specifications" {
  description = "The tags to apply to the resources during launch"
  type        = list(object({
    resource_type = optional(string)
    tags = optional(map(string))
  }))
  default     = []
}

variable "tags" {
  type        = map(string)
  default     = {}
}

