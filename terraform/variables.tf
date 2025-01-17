variable "DB_NAME" {
  description = "Name of LTM postgres DB"
  type        = string
}

variable "DB_USERNAME" {
  description = "Username for LTM postgres DB"
  type        = string
}

variable "DB_PASSWORD" {
  description = "Password for LTM postgres DB"
  type        = string
  sensitive   = true
}

variable "SECRET_KEY_BASE" {
  description = "Rails SECRET_KEY_BASE"
  type        = string
  sensitive   = true
}
