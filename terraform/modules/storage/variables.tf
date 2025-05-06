variable "storage_account_name" {
  type        = string
  description = "Name of the storage account"
}

variable "resource_group_name" {
  type        = string
  description = "Name of the resource group"
}

variable "location" {
  type        = string
  description = "Location for the storage account"
}

variable "environment" {
  type = string
}
variable "container_name" {
  type        = string
  description = "Name of the storage container"
}
