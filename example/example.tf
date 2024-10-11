
locals {
  tags = {
    "created-by" = "Terraform"

  }

  metadata = {
    "key1" = "value1"
    "key2" = "value2"
  }

  naming_convention_info = {
    name         = "001"
    project_code = "knj"
    env          = "dev"
    zone         = "z1"
    agency_code  = "konjur"
    tier         = "dta"
  }

    solution_plan_map = {
        "OEM" = "OMS"
        "PAYG" = "PAYG"
        "Azure" = "Azure"
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

module "log_analytics_workspace" {  
  source =  "git::https://github.com/BrettOJ/tf-az-module-log-analytics?ref=main"
  resource_group_name = module.resource_groups.rg_output.1.name
  location       = var.location
  sku            = "PerGB2018"
  naming_convention_info = local.naming_convention_info
  tags                   = local.tags
  solution_plan_map      = null #local.solution_plan_map 
}


module "l0_storage_account" {
  source              = "git::https://github.com/BrettOJ/tf-az-module-storage-account?ref=main"
  resource_group_name = module.resource_groups.rg_output.1.name
  location            = var.location
  kind                = "StorageV2"
  sku                 = "Standard_LRS"
  access_tier         = "Hot"
  assign_identity     = "SystemAssigned"
  https_traffic_only_enabled = true
  containers = {
    lvl0 = {
      name        = "lvl0"
      access_type = "private"
    }
    lvl1 = {
      name        = "lvl1"
      access_type = "private"
    }
    lvl2 = {
      name        = "lvl2"
      access_type = "private"
    }
  }
    diag_object = {
    log_analytics_workspace_id = module.log_analytics_workspace.loga_output.id
    enabled_log = [
      ["StorageDelete", true, true, 80],
    ]
    metric = [
      ["AllMetrics", true, true, 80],
    ]
  }
  
  naming_convention_info = local.naming_convention_info
  tags                   = local.tags
}
