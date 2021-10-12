variable "secrets" {
  description = "Map of secrets to keep in AWS Secrets Manager"
  type        = any
  default     = {}
}

variable "tags" {
  description = "Specifies a key-value map of user-defined tags that are attached to the secret."
  type        = any
  default     = {}
}