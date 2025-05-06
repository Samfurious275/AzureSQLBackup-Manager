variable "keyvault_name" {
  type        = string
  description = "Name of the Key Vault"
}

variable "resource_group_name" {
  type        = string
  description = "Name of the resource group"
}

variable "location" {
  type        = string
  description = "Location for the Key Vault"
}

variable "tenant_id" {
  type        = string
  description = "Azure AD Tenant ID"
}

variable "object_id" {
  type        = string
  description = "Object ID of the principal (e.g., SQL Server managed identity)"
}

variable "environment" {
  type = string
}
variable "principal_id" {
  type = string
}
