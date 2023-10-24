# Variable fiel for an Azure Storage Account

variable "resource_group_name" {
  type        = string
  description = "The name of the resource group in which to create the storage account"
}

variable "location" {
  type        = string
  description = "Specifies the supported Azure location where the resource exists"
  default = "southeastasia"
}

variable  "naming_convention_info" {
  type = object({
    name = string
    project_code = string
    env = string
    zone = string
    tier = string
  })
  description = "Naming convention object"
}
variable "containers" {
  type        = map(object({
    name = string
    container_access_type  = string
  
  }))
  description = "A mapping of containers to create within the Storage Account"
  default     = null
}

variable "account_kind" {
  type = string
  description = "Defines the Kind of account. Valid options are BlobStorage, BlockBlobStorage, FileStorage, Storage and StorageV2. Defaults to StorageV2"
  default = "StorageV2"
}

variable "account_tier" {
  type = string
  description = "Defines the Tier to use for this storage account. Valid options are Standard and Premium. For BlockBlobStorage and FileStorage accounts only Premium is valid"
  default = "Standard"
}

variable "account_replication_type" {
  type = string
  description = "Defines the type of replication to use for this storage account. Valid options are LRS, GRS, RAGRS, ZRS, GZRS and RAGZRS"
  default = "LRS"
}

variable "cross_tenant_replication_enabled" {
  type = bool
  description = "Should cross Tenant replication be enabled?"
  default = true
}

variable "access_tier" {
  type = string
  description = "Defines the access tier for BlobStorage, FileStorage and StorageV2 accounts. Valid options are Hot and Cool, defaults to Hot"
  default = "Hot"
}

variable "edge_zone" {
  type = string
  description = "Specifies the Edge Zone within the Azure Region where this Storage Account should exist"
}

variable "enable_https_traffic_only" {
  type = bool
  description = "Boolean flag which forces HTTPS if enabled, see here for more information"
  default = true
}

variable "min_tls_version" {
  type = string
  description = "The minimum supported TLS version for the storage account. Possible values are TLS1_0, TLS1_1, and TLS1_2. Defaults to TLS1_2 for new storage accounts"
  default = "TLS1_2"
}

variable "allow_nested_items_to_be_public" {
  type = bool
  description = "Allow or disallow nested items within this Account to opt into being public. Defaults to true"
  default = true
}

variable "shared_access_key_enabled" {
  type = bool
  description = "Indicates whether the storage account permits requests to be authorized with the account access key via Shared Key. If false, then all requests, including shared access signatures, must be authorized with Azure Active Directory (Azure AD). The default value is true"
  default = true
}

variable "public_network_access_enabled" {
  type = bool
  description = "Whether the public network access is enabled? Defaults to true"
  default = true
}

variable "default_to_oauth_authentication" {
  type = bool
  description = "Default to Azure Active Directory authorization in the Azure portal when accessing the Storage Account. The default value is false"
  default = false
}

variable "is_hns_enabled" {
  type = bool
  description = "Is Hierarchical Namespace enabled? This can be used with Azure Data Lake Storage Gen 2 (see here for more information)"
  default = false
}

variable "nfsv3_enabled" {
  type = bool
  description = "Is NFSv3 protocol enabled?"
  default = false
}

variable "large_file_share_enabled" {
  type = bool
  description = "Is Large File Share Enabled?"
}   

variable "queue_encryption_key_type" {
  type = string
  description = "The encryption type of the queue service. Possible values are Service and Account. Changing this forces a new resource to be created. Default value is Service"
  default = "Service"
}

variable "table_encryption_key_type" {
  type = string
  description = "The encryption type of the table service. Possible values are Service and Account. Changing this forces a new resource to be created. Default value is Service"
  default = "Service"
}

variable "infrastructure_encryption_enabled" {
  type = bool
  description = "Is infrastructure encryption enabled? Defaults to false"
  default = false
}

variable "allowed_copy_scope" {
  type = string
  description = "Restrict copy to and from Storage Accounts within an AAD tenant or with Private Links to the same VNet. Possible values are AAD and PrivateLink"
}

variable "sftp_enabled" {
  type = bool
  description = "Boolean, enable SFTP for the storage account"
  default = false
}

variable "tags" {
  type = map(string)
  description = "A mapping of tags to assign to the resource"
  default = {}
}

variable "blob_properties" {
  type = object({
    cors_rule = object({
      allowed_headers = list(string)
      allowed_methods = list(string)
      allowed_origins = list(string)
      exposed_headers = list(string)
      max_age_in_seconds = number
    })
    delete_retention_policy = object({
      days = number
    })
    restore_policy = object({
      days = number
    })
    versioning_enabled = bool
    change_feed_enabled = bool
    change_feed_retention_in_days = number
    default_service_version = string
    last_access_time_enabled = bool
    container_delete_retention_policy = object({
      days = number
    })
  })
  default = {
    cors_rule = {
      allowed_headers = null
      allowed_methods = null
      allowed_origins = null
      exposed_headers = null
      max_age_in_seconds = null
    }
    delete_retention_policy = {
      days = null
    }
    restore_policy = {
      days = null
    }
    versioning_enabled = null
    change_feed_enabled = null
    change_feed_retention_in_days = null
    default_service_version = null
    last_access_time_enabled = null
    container_delete_retention_policy = {
      days = null
    }
}
}

variable "custom_domain" {
  type = object({
    name = string
    use_subdomain = bool
  })
  default = null
}

variable "customer_managed_key" {
  type = object({
    key_vault_key_id = string
    user_assigned_identity_id = string
  })
  default = null
}

variable "delete_retention_policy" {
    type = object({
        days = number
    })
    default = null
}

variable "restore_policy" {
    type = object({
        days = number
    })
    default = null
}

variable "container_delete_retention_policy" {
    type = object({
        days = number
    })
    default = null
}

variable "hours_metrics" {
    type = object({
        enabled = bool
        version = string
        include_apis = bool
        retention_policy_days = number
    })
    default = null
}

variable "identity" {
    type = object({
        type = string
        identity_ids = list(string)
    })
    default = null
}

variable "immutability_policy" {
    type = object({
        allow_protected_append_writes = bool
        state = string
        period_since_creation_in_days = number
    })
    default = null
}

variable "logging" {
    type = object({
        delete = bool
        read = bool
        version = string
        write = bool
        retention_policy_days = number
    })
    default = null
}

variable "minute_metrics" {
    type = object({
        enabled = bool
        version = string
        include_apis = bool
        retention_policy_days = number
    })
    default = null
}

variable "network_rules" {
    type = object({
        bypass = set(string)
        default_action = string
        ip_rules = list(string)
        virtual_network_subnet_ids = list(string)
        private_link_access = object({
            endpoint_resource_id = string
            endpoint_tenant_id = string
        })
    })
    default = null
}
  
variable "azure_files_authentication" {
    type = object({
        directory_type = string
        active_directory = object({
            storage_sid = string
            domain_name = string
            domain_sid = string
            domain_guid = string
            forest_name = string
            netbios_domain_name = string
        })
    })
    default = null
}

variable "routing" {
    type = object({
        publish_internet_endpoints = bool
        publish_microsoft_endpoints = bool
        choice = string
    })
    default = null
}

variable "queue_properties" {
    type = object({
        cors_rule = object({
            allowed_headers = list(string)
            allowed_methods = list(string)
            allowed_origins = list(string)
            exposed_headers = list(string)
            max_age_in_seconds = number
        })
        logging = object({
            delete = bool
            read = bool
            version = string
            write = bool
            retention_policy_days = number
        })
        minute_metrics = object({
            enabled = bool
            version = string
            include_apis = bool
            retention_policy_days = number
        })
        hour_metrics = object({
            enabled = bool
            version = string
            include_apis = bool
            retention_policy_days = number
        })
    })
    default = {
        cors_rule = {
            allowed_headers = null
            allowed_methods = null
            allowed_origins = null
            exposed_headers = null
            max_age_in_seconds = null
        }
        logging = {
            delete = null
            read = null
            version = null
            write = null
            retention_policy_days = null
        }
        minute_metrics = {
            enabled = null
            version = null
            include_apis = null
            retention_policy_days = null
        }
        hour_metrics = {
            enabled = null
            version = null
            include_apis = null
            retention_policy_days = null
        }
    }
}

variable "sas_policy" {
    type = object({
        expiration_period = string
        expiration_action = string
    })
    default = null
}

variable "static_website" {
    type = object({
        index_document = string
        error_404_document = string
    })
    default = null
}

variable "share_properties" {
    type = object({
        cors_rule = object({
            allowed_headers = list(string)
            allowed_methods = list(string)
            allowed_origins = list(string)
            exposed_headers = list(string)
            max_age_in_seconds = number
        })
        retention_policy = object({
            days = number
        })
        smb = object({
            versions = list(string)
            authentication_types = list(string)
            kerberos_ticket_encryption_type = list(string)
            channel_encryption_type = list(string)
            multichannel_enabled = bool
        })
    })
    default = {
     cors_rule = {
            allowed_headers = null
            allowed_methods = null
            allowed_origins = null
            exposed_headers = null
            max_age_in_seconds = null
        }
      retention_policy = {
            days = null
        }
      smb = {
            versions = null
            authentication_types = null
            kerberos_ticket_encryption_type = null
            channel_encryption_type = null
            multichannel_enabled = null
        }

    }
}