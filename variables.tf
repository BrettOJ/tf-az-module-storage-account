
variable "resource_group_name" {
  type        = string
  description = "The name of an existing resource group."
}

variable "location" {
  type        = string
  default     = ""
  description = "The name of the location."
}

variable "kind" {
  type        = string
  default     = "Storage"
  description = "The kind of storage account. Supports BlobStorage, BlockBlobStorage, FileStorage, Storage and StorageV2"
}

variable "sku" {
  type        = string
  default     = "Standard_RAGRS"
  description = "The SKU of the storage account."
}

variable "access_tier" {
  type        = string
  default     = "Hot"
  description = "The access tier of the storage account."
}

variable "https_only" {
  type        = bool
  default     = true
  description = "Set to `true` to only allow HTTPS traffic, or `false` to disable it."
}

variable "assign_identity" {
  type        = string
  default     = "SystemAssigned"
  description = "Set to `true` to enable system-assigned managed identity, or `false` to disable it."
}

variable "containers" {
  type = map(object({
    name        = string
    access_type = string
  }))
  default     = {}
  description = "List of storage containers."
}


variable "diag_object" {
  description = "contains the logs and metrics for diagnostics"
  default     = null
  type = object({
    log_analytics_workspace_id = string
    log                        = list(tuple([string, bool, bool, number]))
    metric                     = list(tuple([string, bool, bool, number]))
  })
}

variable "blob_diag_object" {
  description = "contains the logs and metrics for diagnostics"
  default     = null
  type = object({
    log_analytics_workspace_id = string
    log                        = list(tuple([string, bool, bool, number]))
    metric                     = list(tuple([string, bool, bool, number]))
  })
}

variable "que_diag_object" {
  description = "contains the logs and metrics for diagnostics"
  default     = null
  type = object({
    log_analytics_workspace_id = string
    log                        = list(tuple([string, bool, bool, number]))
    metric                     = list(tuple([string, bool, bool, number]))
  })
}

variable "table_diag_object" {
  description = "contains the logs and metrics for diagnostics"
  default     = null
  type = object({
    log_analytics_workspace_id = string
    log                        = list(tuple([string, bool, bool, number]))
    metric                     = list(tuple([string, bool, bool, number]))
  })
}

variable "file_diag_object" {
  description = "contains the logs and metrics for diagnostics"
  default     = null
  type = object({
    log_analytics_workspace_id = string
    log                        = list(tuple([string, bool, bool, number]))
    metric                     = list(tuple([string, bool, bool, number]))
  })
}

variable "naming_convention_info" {
  description = "(Required) Specify the naming convention information to the resource."
  type = object({
    name         = string
    agency_code  = string
    project_code = string
    env          = string
    zone         = string
    tier         = string
  })
}

variable "tags" {
  type        = map(string)
  description = "Specify the tags to the resource. Additional tags will be appended based on the convention"
}

variable "dependencies" {
  type        = list
  description = "List of dependecies modules or resources"
  default     = null
}

variable "network_rules" {
  type = object({
    action         = string
    ips            = list(string)
    subnets        = list(string)
    traffic_bypass = list(string)
  })
  default = null
}

variable "static_website" {
  description = "(Optional) Enable static website blob feature for storage account"
  type = object({
    index_document     = string
    error_404_document = string
  })
  default = null
}

variable "cors_rule" {
  description = "(Optional) Enable CORS policies for storage account"
  type = list(object({
    allowed_headers    = list(string)
    allowed_methods    = list(string)
    allowed_origins    = list(string)
    exposed_headers    = list(string)
    max_age_in_seconds = number
  }))
  default = null
}

variable "delete_retention_policy_days" {
  description = "(Optional) Delete retention policy in days"
  type        = number
  default     = 7
}

variable "custom_domain" {
  description = "(Optional) Specify the Custom Domain for storage account"
  type = object({
    name          = string
    use_subdomain = bool
  })
  default = null
}

variable "encryption_info" {
  type = object({
    key_vault_id          = string
    key_vault_key_name    = string
    key_vault_key_version = string
  })
  description = "(Optional) Customer Managed key for Storage Account level Encryption at rest."
  default     = null
}

variable "tls_version" {
  type        = string
  description = "(Optional) Specify the min tls version. Default to 1.2"
  default     = "TLS1_2"
}

variable "public_network_access_enabled" {
  type    = bool
  default = false
}