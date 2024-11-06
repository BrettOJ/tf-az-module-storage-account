locals {
  account_tier             = (var.kind == "FileStorage" ? "Premium" : split("_", var.sku)[0])
  account_replication_type = (local.account_tier == "Premium" ? "LRS" : split("_", var.sku)[1])
}

resource "azurerm_storage_account" "sst_obj" {
  name                      = module.sst_name.naming_convention_output[var.naming_convention_info.name].names.0
  resource_group_name       = var.resource_group_name
  location                  = var.location
  account_kind              = var.kind
  account_tier              = local.account_tier
  account_replication_type  = local.account_replication_type
  access_tier               = var.access_tier
  https_traffic_only_enabled  = var.https_traffic_only_enabled
  tags                      = module.sst_name.naming_convention_output[var.naming_convention_info.name].tags.0
  min_tls_version           = var.tls_version
  
  dynamic "static_website" {
    for_each = var.static_website == null ? [] : [1]
    content {
      index_document     = var.static_website.index_document
      error_404_document = var.static_website.error_404_document
    }
  }

  blob_properties {
    dynamic "cors_rule" {
      for_each = var.cors_rule != null ? var.cors_rule : []
      content {
        allowed_headers    = cors_rule.value.allowed_headers
        allowed_methods    = cors_rule.value.allowed_methods
        allowed_origins    = cors_rule.value.allowed_origins
        exposed_headers    = cors_rule.value.exposed_headers
        max_age_in_seconds = cors_rule.value.max_age_in_seconds
      }
    }

    delete_retention_policy {
      days = var.delete_retention_policy_days
    }
  }

  dynamic "custom_domain" {
    for_each = var.custom_domain == null ? [] : [1]
    content {
      name          = var.custom_domain.name
      use_subdomain = var.custom_domain.use_subdomain
    }
  }

  identity {
    type = var.assign_identity # ? "SystemAssigned" : null
  }

}

resource "azurerm_storage_container" "ss_cnt_obj" {
  for_each              = var.containers
  name                  = each.value.key #coalesce(each.value.name, module.sst_cnt_name.naming_convention_output[each.key].names.0)
  storage_account_name  = azurerm_storage_account.sst_obj.name
  container_access_type = each.value.access_type
}


resource "azurerm_advanced_threat_protection" "threat_obj" {
  target_resource_id = azurerm_storage_account.sst_obj.id
  enabled            = true
  depends_on         = [azurerm_storage_account.sst_obj]

}


resource "azurerm_storage_account_network_rules" "nw_rules" {
  count                = var.network_rules == null ? 0 : 1
  storage_account_id  = azurerm_storage_account.sst_obj.id

  default_action             = var.network_rules.action
  ip_rules                   = var.network_rules.ips
  virtual_network_subnet_ids = var.network_rules.subnets
  bypass                     = var.network_rules.traffic_bypass
  depends_on                 = [azurerm_storage_account.sst_obj]
}

resource "azurerm_key_vault_access_policy" "storage_account_encryption_cmk_akv_access_policies" {
  for_each     = var.encryption_info == null ? {} : { "${azurerm_storage_account.sst_obj.name}" = var.encryption_info }
  key_vault_id = var.encryption_info.key_vault_id
  tenant_id    = azurerm_storage_account.sst_obj.identity[0].tenant_id
  object_id    = azurerm_storage_account.sst_obj.identity[0].principal_id

  key_permissions = [
    "Get", "WrapKey", "UnwrapKey"
  ]
}


resource "azurerm_storage_account_customer_managed_key" "storage_account_encryption_cmk" {
  for_each           = var.encryption_info == null ? {} : { "${azurerm_storage_account.sst_obj.name}" = var.encryption_info }
  storage_account_id = azurerm_storage_account.sst_obj.id
  key_vault_id       = var.encryption_info.key_vault_id
  key_name           = var.encryption_info.key_vault_key_name
  key_version        = var.encryption_info.key_vault_key_version
  depends_on         = [azurerm_key_vault_access_policy.storage_account_encryption_cmk_akv_access_policies]
}