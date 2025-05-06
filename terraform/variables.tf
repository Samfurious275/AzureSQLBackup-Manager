# Required for SQL Module
variable "sql_admin_password" {
  type        = string
  description = "SQL Server administrator password"
  sensitive   = true
}

# Optional: Add environment if needed
variable "environment" {
  type        = string
  default     = "dev"
  description = "Deployment environment (e.g., dev, prod)"
}
