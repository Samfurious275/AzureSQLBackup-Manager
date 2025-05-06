variable "sql_server_name" {
  type        = string
  description = "Name of the SQL Server"
}

variable "resource_group_name" {
  type        = string
  description = "Name of the resource group"
}

variable "location" {
  type        = string
  description = "Location for the SQL Server"
}

variable "admin_username" {
  type        = string
  description = "Admin username for SQL Server"
}

variable "admin_password" {
  type        = string
  sensitive   = true
  description = "Admin password for SQL Server"
}

variable "database_name" {
  type        = string
  description = "Name of the SQL Database"
}

variable "environment" {
  type = string
}

variable "sql_admin_password" {
  type      = string
  sensitive = true
}
