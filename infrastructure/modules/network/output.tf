output "virtual_network_id" {
  description = "Virtual network id"
  value       = azurerm_virtual_network.virtual_network.id
}

output "subnet_ids" {
  description = "Subnet ids"
  value       = { for k, v in azurerm_subnet.subnet : k => v.id }
}