
locals {
  tags = {
    "created-by" = "Terraform"

  }

  naming_convention_info = {
    name         = "eg"
    project_code = "boj"
    env          = "dev"
    zone         = "z1"
    agency_code  = "brettoj"
    tier         = "web"
  }

}

module "resource_groups" {
  source = "git::https://github.com/BrettOJ/tf-az-module-resource-group?ref=main"
  resource_groups = {
    1 = {
      name                   = var.resource_group_name
      location               = var.location
      naming_convention_info = local.naming_convention_info
      tags                   = local.tags
    }
  }
}


module "azure_storage_account" {
  source                   = "../"
  resource_group_name      = module.resource_groups.rg_output[1].name
  location                 = var.location
  account_tier             = var.access_tier
  account_replication_type = var.account_replication_type
naming_convention_info = local.naming_convention_info
  account_kind = var.account_kind

  cross_tenant_replication_enabled  = var.cross_tenant_replication_enabled
  access_tier                       = var.access_tier
  edge_zone                         = var.edge_zone
  enable_https_traffic_only         = var.enable_https_traffic_only
  min_tls_version                   = var.min_tls_version
  allow_nested_items_to_be_public   = var.allow_nested_items_to_be_public
  shared_access_key_enabled         = var.shared_access_key_enabled
  public_network_access_enabled     = var.public_network_access_enabled
  default_to_oauth_authentication   = var.default_to_oauth_authentication
  is_hns_enabled                    = var.is_hns_enabled
  nfsv3_enabled                     = var.nfsv3_enabled
  large_file_share_enabled          = var.large_file_share_enabled
  queue_encryption_key_type         = var.queue_encryption_key_type
  table_encryption_key_type         = var.table_encryption_key_type
  infrastructure_encryption_enabled = var.infrastructure_encryption_enabled
  allowed_copy_scope                = var.allowed_copy_scope
  sftp_enabled                      = var.sftp_enabled
  tags                              = var.tags

containers = {
    name = var.containers.name
    access_type = var.containers.container_access_type 
}

  blob_properties = {
    cors_rule = {
      allowed_headers    = var.blob_properties.cors_rule.allowed_headers
      allowed_methods    = var.blob_properties.cors_rule.allowed_methods
      allowed_origins    = var.blob_properties.cors_rule.allowed_origins
      exposed_headers    = var.blob_properties.cors_rule.exposed_headers
      max_age_in_seconds = var.blob_properties.cors_rule.max_age_in_seconds
    }
    delete_retention_policy = {
      days = var.blob_properties.delete_retention_policy.days
    }
    restore_policy = {
      days = var.blob_properties.restore_policy.days
    }
    versioning_enabled            = var.blob_properties.versioning_enabled
    change_feed_enabled           = var.blob_properties.change_feed_enabled
    change_feed_retention_in_days = var.blob_properties.change_feed_retention_in_days
    default_service_version       = var.blob_properties.default_service_version
    last_access_time_enabled      = var.blob_properties.last_access_time_enabled
    container_delete_retention_policy = {
      days = var.blob_properties.container_delete_retention_policy.days
    }
  }

  custom_domain = {
    name          = var.custom_domain.name
    use_subdomain = var.custom_domain.use_subdomain
  }

  customer_managed_key = {
    key_vault_key_id          = var.customer_managed_key.key_vault_key_id
    user_assigned_identity_id = var.customer_managed_key.user_assigned_identity_id
  }

  delete_retention_policy = {
    days = var.delete_retention_policy.days
  }

  restore_policy = {
    days = var.restore_policy.days
  }

  container_delete_retention_policy = {
    days = var.container_delete_retention_policy.days
  }

  hours_metrics = {
    enabled               = var.hours_metrics.enabled
    version               = var.hours_metrics.version
    include_apis          = var.hours_metrics.include_apis
    retention_policy_days = var.hours_metrics.retention_policy_days
  }

  identity = {
    type         = var.identity.type
    identity_ids = var.identity.identity_ids
  }

  immutability_policy = {
    allow_protected_append_writes = var.immutability_policy.allow_protected_append_writes
    state                         = var.immutability_policy.state
    period_since_creation_in_days = var.immutability_policy.period_since_creation_in_days
  }

  logging = {
    delete                = var.logging.delete
    read                  = var.logging.read
    version               = var.logging.version
    write                 = var.logging.write
    retention_policy_days = var.logging.retention_policy_days
  }

  minute_metrics = {
    enabled               = var.minute_metrics.enabled
    version               = var.minute_metrics.version
    include_apis          = var.minute_metrics.include_apis
    retention_policy_days = var.minute_metrics.retention_policy_days
  }

  network_rules = {
    bypass                     = var.network_rules.bypass
    default_action             = var.network_rules.default_action
    ip_rules                   = var.network_rules.ip_rules
    virtual_network_subnet_ids = var.network_rules.virtual_network_subnet_ids
    private_link_access = {
      endpoint_resource_id = var.network_rules.private_link_access.endpoint_resource_id
      endpoint_tenant_id   = var.network_rules.private_link_access.endpoint_tenant_id
    }
  }

  azure_files_authentication = {
    directory_type = var.azure_files_authentication.directory_type
    active_directory ={
      storage_sid         = var.azure_files_authentication.active_directory.storage_sid
      domain_name         = var.azure_files_authentication.active_directory.domain_name
      domain_sid          = var.azure_files_authentication.active_directory.domain_sid
      domain_guid         = var.azure_files_authentication.active_directory.domain_guid
      forest_name         = var.azure_files_authentication.active_directory.forest_name
      netbios_domain_name = var.azure_files_authentication.active_directory.netbios_domain_name
    }
  }

  routing = {
    publish_internet_endpoints  = var.routing.publish_internet_endpoints
    publish_microsoft_endpoints = var.routing.publish_microsoft_endpoints
    choice                      = var.routing.choice
  }

 queue_properties = {
       cors_rule = {
          allowed_headers    = var.queue_properties.cors_rule.allowed_headers
          allowed_methods    = var.queue_properties.cors_rule.allowed_methods
          allowed_origins    = var.queue_properties.cors_rule.allowed_origins
          exposed_headers    = var.queue_properties.cors_rule.exposed_headers
          max_age_in_seconds = var.queue_properties.cors_rule.max_age_in_seconds
        }
      logging = {
        delete                = var.queue_properties.logging.delete
        read                  = var.queue_properties.logging.read
        version               = var.queue_properties.logging.version
        write                 = var.queue_properties.logging.write
        retention_policy_days = var.queue_properties.logging.retention_policy_days
    }
     minute_metrics = {
        enabled               = var.queue_properties.minute_metrics.enabled
        version               = var.queue_properties.minute_metrics.version
        include_apis          = var.queue_properties.minute_metrics.include_apis
        retention_policy_days = var.queue_properties.minute_metrics.retention_policy_days
    }
      hour_metrics ={
        enabled               = var.queue_properties.hour_metrics.enabled
        version               = var.queue_properties.hour_metrics.version
        include_apis          = var.queue_properties.hour_metrics.include_apis
        retention_policy_days = var.queue_properties.hour_metrics.retention_policy_days
      }
    }

  sas_policy = {
    expiration_period = var.sas_policy.expiration_period
    expiration_action = var.sas_policy.expiration_action
  }

  static_website = {
    index_document     = var.static_website.index_document
    error_404_document = var.static_website.error_404_document
  }

  share_properties = {
    cors_rule = {
      allowed_headers    = var.share_properties.cors_rule.allowed_headers
      allowed_methods    = var.share_properties.cors_rule.allowed_methods
      allowed_origins    = var.share_properties.cors_rule.allowed_origins
      exposed_headers    = var.share_properties.cors_rule.exposed_headers
      max_age_in_seconds = var.share_properties.cors_rule.max_age_in_seconds
    }
    retention_policy = {
      days = var.share_properties.retention_policy.days
    }
    smb = {
      versions                        = var.share_properties.smb.versions
      authentication_types            = var.share_properties.smb.authentication_types
      kerberos_ticket_encryption_type = var.share_properties.smb.kerberos_ticket_encryption_type
      channel_encryption_type         = var.share_properties.smb.channel_encryption_type
      multichannel_enabled            = var.share_properties.smb.multichannel_enabled
    }
  }
}

