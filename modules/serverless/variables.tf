variable "daily_snapshot_time" {
  description = "Time at which daily snapshots will be created"
}

variable "description" {
  description = "Cache description"
  default     = null
}

variable "engine" {
  description = "Cache engine name"
}

variable "kms_key_id" {
  description = "ARN of the KMS key for encryption at rest; if no key is provided, a default KMS key is used"
  default     = null
}

variable "major_engine_version" {
  description = "Cache engine major version"
}

variable "name" {
  description = "Cache name"
}

variable "network_configuration" {
  description = "Network configuration block"
  type = object({
    security_group_ids   = optional(list(string), [])
    security_group_names = optional(list(string), [])
    subnet_ids           = optional(list(string), [])
    subnet_type          = optional(string)
    vpc                  = string
  })
  default = null

  # Validate that either subnet_ids or both subnet_type and vpc are defined.

  validation {
    # TODO: This validation rule should be made more robust.
    condition     = var.network_configuration == null || can(length(var.network_configuration.subnet_ids) > 0 || (var.network_configuration.subnet_type != null && var.network_configuration.vpc != null))
    error_message = "The 'network_configuration' block must define both 'subnet_type' and 'vpc', or must define 'subnet_ids'."
  }

  # Validate subnet_type (if specified).

  validation {
    condition     = try(contains(["campus", "private", "public"], var.network_configuration.subnet_type), true)
    error_message = "The 'subnet_type' specified in the 'network_configuration' block is not one of the valid values 'campus', 'private', or 'public'."
  }
}

variable "snapshot_retention_limit" {
  type        = number
  description = "Number of snapshots retained"
  default     = 7
}

variable "tags" {
  description = "Tags to be applied to resources where supported"
  type        = map(string)
  default     = {}
}

# Debugging.

variable "_debug" {
  description = "Produce debug output (boolean)"
  type        = bool
  default     = false
}
