output "virtual_network_name" {
  description = "Virtual network name"
  value       = azurerm_virtual_network.virtual_network.name
}

output "virtual_network_id" {
  description = "Virtual network id"
  value       = azurerm_virtual_network.virtual_network.id
}

output "subnet_names" {
  description = "Subnet names"
  value       = { for k, v in azurerm_subnet.subnet : k => v.name }
}

output "subnet_ids" {
  description = "Subnet ids"
  value       = { for k, v in azurerm_subnet.subnet : k => v.id }
}