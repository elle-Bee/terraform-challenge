resource "aws_launch_template" "launch_template" {
  name = format("%s-lt", var.lt_name)
  dynamic "block_device_mappings" {
    for_each = var.block_device_mappings
    content {
      device_name = block_device_mappings.value.device_name

      dynamic "ebs" {
        for_each = block_device_mappings.value.ebs != null ? [block_device_mappings.value.ebs] : {}
        content {
          volume_size           = ebs.value.volume_size
          delete_on_termination = ebs.value.delete_on_termination
          encrypted             = ebs.value.encrypted
          iops                  = ebs.value.iops
          kms_key_id            = ebs.value.kms_key_id
          snapshot_id           = ebs.value.snapshot_id
          throughput            = ebs.value.throughput
          volume_type           = ebs.value.volume_type
        }
      }
      no_device    = block_device_mappings.value.no_device
      virtual_name = block_device_mappings.value.virtual_name
    }
  }

  dynamic "capacity_reservation_specification" {
    for_each                        = var.capacity_reservation_specification != null ? var.capacity_reservation_specification : []
    content {
      capacity_reservation_preference = capacity_reservation_specification.value.capacity_reservation_preference

      dynamic "capacity_reservation_target" {
        for_each = capacity_reservation_specification.value.capacity_reservation_target != null ? capacity_reservation_specification.value.capacity_reservation_target : {}
        content {
          capacity_reservation_id                 = each.value.capacity_reservation_id
          capacity_reservation_resource_group_arn = each.value.capacity_reservation_resource_group_arn
        }
      }
    }
  }

  dynamic "cpu_options" {
    for_each = var.cpu_options != null ? var.cpu_options : {}
    content {
      amd_sev_snp      = each.value.amd_sev_snp
      core_count       = each.value.core_count
      threads_per_core = each.value.threads_per_core
    }
  }

  credit_specification {
    cpu_credits = var.cpu_credits
  }

  disable_api_stop        = var.disable_api_stop
  disable_api_termination = var.disable_api_termination

  ebs_optimized = var.ebs_optimized

  dynamic "elastic_gpu_specifications" {
    for_each = var.elastic_gpu_specifications != null ? var.elastic_gpu_specifications : {}
    content {
    type = elastic_gpu_specifications.value.elastic_gpu_specifications_type
    }
  }
  image_id = var.image_id

  instance_initiated_shutdown_behavior = var.instance_initiated_shutdown_behavior

  dynamic "instance_market_options" {
    for_each = length(var.instance_market_options) > 0 ? [var.instance_market_options] : []
    content {
      market_type = instance_market_options.value.market_type

      dynamic "spot_options" {
        for_each = try([instance_market_options.value.spot_options], [])
        content {
          block_duration_minutes         = try(spot_options.value.block_duration_minutes, null)
          instance_interruption_behavior = try(spot_options.value.instance_interruption_behavior, null)
          max_price                      = try(spot_options.value.max_price, null)
          spot_instance_type             = try(spot_options.value.spot_instance_type, null)
          valid_until                    = try(spot_options.value.valid_until, null)
        }
      }
    }
  }

  instance_type = var.instance_type
  kernel_id     = can(regex("^aki", var.kernel_id)) ? var.kernel_id : null
  key_name      = var.key_name

  dynamic "license_specification" {
    for_each = var.license_configuration != null ? var.license_configuration : {}
    content {
      license_configuration_arn = license_configuration.value.license_configuration_arn
    }
  }

  dynamic "metadata_options" {
    for_each = var.metadata_options_block != null ?  var.metadata_options_block : []
    content {
      http_endpoint               = metadata_options.value.http_endpoint
      http_tokens                 = metadata_options.value.http_tokens
      http_put_response_hop_limit = metadata_options.value.http_put_response_hop_limit
      http_protocol_ipv6          = metadata_options.value.http_protocol_ipv6
      instance_metadata_tags      = metadata_options.value.instance_metadata_tags
    }
  }

  dynamic "monitoring" {
    for_each = var.enable_monitoring ? [1] : []
    content {
      enabled = var.enable_monitoring
    }
  }

dynamic "network_interfaces" {
    for_each = var.network_interfaces != null ? var.network_interfaces : []
    content {
      associate_carrier_ip_address = try(network_interfaces.value.associate_carrier_ip_address, null)
      associate_public_ip_address  = try(network_interfaces.value.associate_public_ip_address, null)
      delete_on_termination        = try(network_interfaces.value.delete_on_termination, null)
      description                  = try(network_interfaces.value.description, null)
      device_index                 = try(network_interfaces.value.device_index, null)
      interface_type               = try(network_interfaces.value.interface_type, null)
      ipv4_prefix_count            = try(network_interfaces.value.ipv4_prefix_count, null)
      ipv4_prefixes                = try(network_interfaces.value.ipv4_prefixes, null)
      ipv4_addresses               = try(network_interfaces.value.ipv4_addresses, [])
      ipv4_address_count           = try(network_interfaces.value.ipv4_address_count, null)
      ipv6_prefix_count            = try(network_interfaces.value.ipv6_prefix_count, null)
      ipv6_prefixes                = try(network_interfaces.value.ipv6_prefixes, [])
      ipv6_addresses               = try(network_interfaces.value.ipv6_addresses, [])
      ipv6_address_count           = try(network_interfaces.value.ipv6_address_count, null)
      network_interface_id         = try(network_interfaces.value.network_interface_id, null)
      network_card_index           = try(network_interfaces.value.network_card_index, null)
      private_ip_address           = try(network_interfaces.value.private_ip_address, null)
      security_groups              = compact(concat(try(network_interfaces.value.security_groups, []), var.security_groups))
      subnet_id                    = coalesce(length(network_interfaces.value.subnet_id) > 0 ? network_interfaces.value.subnet_id[0] : null, null)
    }
  }

  dynamic "placement" {
    for_each = var.placement_values != {} ? var.placement_values : {}
    content {
      affinity                = lookup(var.placement_values, "affinity", null)
      availability_zone       = lookup(var.placement_values, "availability_zone", null)
      group_name              = lookup(var.placement_values, "group_name", null)
      host_id                 = lookup(var.placement_values, "host_id", null)
      host_resource_group_arn = lookup(var.placement_values, "host_resource_group_arn", null)
      spread_domain           = lookup(var.placement_values, "spread_domain", null)
      tenancy                 = lookup(var.placement_values, "tenancy", null)
      partition_number        = lookup(var.placement_values, "partition_number", null)
    }
  }

  dynamic "private_dns_name_options" {
    for_each = var.private_dns_name_options != null ? var.private_dns_name_options : []
    content {
      enable_resource_name_dns_aaaa_record = private_dns_name_options.value.enable_resource_name_dns_aaaa_record
      enable_resource_name_dns_a_record    = private_dns_name_options.value.enable_resource_name_dns_a_record
      hostname_type                        = private_dns_name_options.value.hostname_type
    }
  }

  ram_disk_id            = can(regex("^ari", var.ram_disk_id)) ? var.ram_disk_id : null

  dynamic "tag_specifications" {
    for_each = var.tag_specifications != null ? var.tag_specifications : []
    content {
      resource_type = tag_specifications.value.resource_type
      tags          = try(merge(var.tags, try(tag_specifications.value.tags, {})))
    }
  }
  user_data              = base64encode(var.user_data)
  default_version        = var.default_version
  update_default_version = var.update_default_version
  description            = var.launch_template_description

  dynamic "maintenance_options" {
    for_each = length(var.maintenance_options) > 0 ? [var.maintenance_options] : []
    content {
      auto_recovery = try(maintenance_options.value.auto_recovery, null)
    }
  }
}