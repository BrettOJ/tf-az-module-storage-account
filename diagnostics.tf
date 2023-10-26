locals {
  diag_object = var.diag_object == null ? null : {
    "${var.naming_convention_info.name}" = {
      resource_id = ["${azurerm_storage_account.sst_obj.id}/blobServices/default"]
      log         = var.diag_object.log
      metric      = var.diag_object.metric
    }
  }
  blob_diag_object = var.blob_diag_object == null ? null : {
    "${var.naming_convention_info.name}" = {
      resource_id = ["${azurerm_storage_account.sst_obj.id}/blobServices/default"]
      log         = var.blob_diag_object.log
      metric      = var.blob_diag_object.metric
    }
  }
  que_diag_object = var.que_diag_object == null ? null : {
    "${var.naming_convention_info.name}" = {
      resource_id = ["${azurerm_storage_account.sst_obj.id}/queueServices/default"]
      log         = var.blob_diag_object.log
      metric      = var.blob_diag_object.metric
    }
  }
  table_diag_object = var.table_diag_object == null ? null : {
    "${var.naming_convention_info.name}" = {
      resource_id = ["${azurerm_storage_account.sst_obj.id}/tableServices/default"]
      log         = var.blob_diag_object.log
      metric      = var.blob_diag_object.metric
    }
  }
  file_diag_object = var.table_diag_object == null ? null : {
    "${var.naming_convention_info.name}" = {
      resource_id = ["${azurerm_storage_account.sst_obj.id}/fileServices/default"]
      log         = var.blob_diag_object.log
      metric      = var.blob_diag_object.metric
    }
  }
  # cnt_diag_object = {
  #   for key, value in var.containers :
  #   "${key}" => {
  #     resource_id = [azurerm_storage_container.ss_cnt_obj[key].id]
  #     log         = var.diag_object.log
  #     metric      = var.diag_object.metric
  #   }
  # }
}

module "diagnostics" {
  source = "git::https://github.com/BrettOJ/tf-az-module-diagnostics-settings?ref=main"

  log_analytics_workspace_id = var.diag_object == null || var.diag_object == {} ? "" : var.diag_object.log_analytics_workspace_id
  diag_object                = local.diag_object
  naming_convention_info     = var.naming_convention_info
  dependencies               = [azurerm_storage_account.sst_obj]
  resource_type              = "sstdiag"
  tags                       = var.tags
}

module "blob_diagnostics" {
  source = "git::https://github.com/BrettOJ/tf-az-module-diagnostics-settings?ref=main"

  log_analytics_workspace_id = var.blob_diag_object == null || var.blob_diag_object == {} ? "" : var.blob_diag_object.log_analytics_workspace_id
  diag_object                = local.blob_diag_object
  naming_convention_info     = var.naming_convention_info
  dependencies               = [azurerm_storage_account.sst_obj]
  resource_type              = "blobdiag"
  tags                       = var.tags
}

module "que_diagnostics" {
  source = "git::https://github.com/BrettOJ/tf-az-module-diagnostics-settings?ref=main"

  log_analytics_workspace_id = var.que_diag_object == null || var.que_diag_object == {} ? "" : var.que_diag_object.log_analytics_workspace_id
  diag_object                = local.que_diag_object
  naming_convention_info     = var.naming_convention_info
  dependencies               = [azurerm_storage_account.sst_obj]
  resource_type              = "quediag"
  tags                       = var.tags
}

module "file_diagnostics" {
 source = "git::https://github.com/BrettOJ/tf-az-module-diagnostics-settings?ref=main"

  log_analytics_workspace_id = var.file_diag_object == null || var.file_diag_object == {} ? "" : var.file_diag_object.log_analytics_workspace_id
  diag_object                = local.file_diag_object
  naming_convention_info     = var.naming_convention_info
  dependencies               = [azurerm_storage_account.sst_obj]
  resource_type              = "filediag"
  tags                       = var.tags
}

module "tbl_diagnostics" {
  source = "git::https://github.com/BrettOJ/tf-az-module-diagnostics-settings?ref=main"

  log_analytics_workspace_id = var.table_diag_object == null || var.table_diag_object == {} ? "" : var.table_diag_object.log_analytics_workspace_id
  diag_object                = local.table_diag_object
  naming_convention_info     = var.naming_convention_info
  dependencies               = [azurerm_storage_account.sst_obj]
  resource_type              = "tbldiag"
  tags                       = var.tags
}

# module "diagnostics_container" {
#   source = "git::https://github.com/BrettOJ/tf-az-module-diagnostics-settings?ref=main"

#   log_analytics_workspace_id      = var.diag_object.log_analytics_workspace_id
#   diag_object                     = local.cnt_diag_object
#   naming_convention_info          = var.naming_convention_info
#   dependencies                    = [azurerm_storage_account.sst_obj]
#   resource_type                   = "cntdiag" 
#   tags                            = var.tags
# }