resource "azurerm_key_vault_secret" "github_runners_access_token" {
  name         = "github-runners-access-token"
  value        = "placeholder"
  key_vault_id = azurerm_key_vault.github_kv.id

  lifecycle {
    ignore_changes = [value]
  }
}