output "sst_output" {
  value       = azurerm_storage_account.sst_obj
  description = "Storage account object"
}

# output "blob_diag" {
#   value = null_resource.blob_diagnostics_setting
#   description = "Blob diagnostics settings object"
# }

output "cnt_output" {
  value = {
    for k, c in azurerm_storage_container.ss_cnt_obj :
    "${k}" => {
      id   = c.id
      name = c.name
    }
  }
  description = "Map of containers."
}

