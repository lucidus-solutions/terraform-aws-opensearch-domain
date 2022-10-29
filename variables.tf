variable "app" {
  type        = string
  description = "The name of the application or project that the stack supports"
  sensitive   = false
}

variable "automated_snapshot_start_hour" {
  type        = number
  description = ""
  default     = 0
  sensitive   = false
}

variable "autotune_cron_schedule" {
  type        = string
  description = ""
  default     = "cron(0 0 ? * 1 *)"
  sensitive   = false
}

variable "autotune_desired_state" {
  type        = string
  description = ""
  default     = "ENABLED"
  sensitive   = false
}

variable "autotune_duration_unit" {
  type        = string
  description = ""
  default     = "HOURS"
  sensitive   = false
}

variable "autotune_duration_value" {
  type        = number
  description = ""
  default     = 2
  sensitive   = false
}

variable "autotune_rollback_on_disable" {
  type        = string
  description = ""
  default     = "NO_ROLLBACK"
  sensitive   = false
}

variable "autotune_start_datetime" {
  type        = string
  description = ""
  default     = "2022-10-30T20:20:31Z"
  sensitive   = false
}

variable "availability_zones" {
  type        = set(string)
  description = ""
  sensitive   = false
}

variable "cognito_enabled" {
  type        = bool
  description = ""
  default     = false
  sensitive   = false
}

variable "cognito_identity_pool_id" {
  type        = string
  description = ""
  default     = null
  sensitive   = false
}

variable "cognito_role_arn" {
  type        = string
  description = ""
  default     = null
  sensitive   = false
}

variable "cognito_user_pool_id" {
  type        = string
  description = ""
  default     = null
  sensitive   = false
}

variable "cold_storage_enabled" {
  type        = bool
  description = ""
  default     = false
  sensitive   = false
}

variable "custom_endpoint" {
  type        = string
  description = ""
  default     = null
  sensitive   = false
}

variable "custom_endpoint_certificate_arn" {
  type        = string
  description = ""
  default     = null
  sensitive   = false
}

variable "custom_endpoint_enabled" {
  type        = bool
  description = ""
  default     = false
  sensitive   = false
}

variable "data_node_count" {
  type        = number
  description = ""
  default     = 2
  sensitive   = false
}

variable "data_node_type" {
  type        = string
  description = ""
  default     = "r6g.large.search"
  sensitive   = false
}

variable "dedicated_master_count" {
  type        = number
  description = ""
  default     = 0
  sensitive   = false
}

variable "dedicated_master_enabled" {
  type        = bool
  description = ""
  default     = false
  sensitive   = false
}

variable "ebs_enabled" {
  type        = bool
  description = ""
  default     = true
  sensitive   = false
}

variable "ebs_iops" {
  type        = number
  description = ""
  default     = 3000
  sensitive   = false
}

variable "ebs_throughput" {
  type        = number
  description = ""
  default     = 125
  sensitive   = false
}

variable "ebs_volume_size" {
  type        = number
  description = ""
  default     = 10
  sensitive   = false
}

variable "ebs_volume_type" {
  type        = string
  description = ""
  default     = "gp3"
  sensitive   = false
}

variable "encrypt_at_rest" {
  type        = bool
  description = ""
  default     = true
  sensitive   = false
}

variable "enforce_https" {
  type        = bool
  description = ""
  default     = true
  sensitive   = false
}

variable "engine_version" {
  type        = string
  description = ""
  default     = "OpenSearch_1.3"
  sensitive   = false
}

variable "env" {
  type        = string
  description = "The target environment for the stack - could be a tier or account level reference"
  sensitive   = false
  validation {
    condition     = contains(["dev", "qa", "stage", "prod", "demo", "perf", "nonprod", "prod"], var.env)
    error_message = "Must be one of the following: dev, qa, stage, prod, demo, perf,nonprod, prod"
  }
}

variable "indicies_fielddata_cache_size" {
  type        = string
  description = ""
  default     = "40"
  sensitive   = false
}

variable "indicies_query_bool_max_clause_count" {
  type      = string
  default   = "1024"
  sensitive = false
}

variable "kms_key_id" {
  type        = string
  description = ""
  default     = null
  sensitive   = false
}

variable "node_to_node_encryption" {
  type        = bool
  description = ""
  default     = true
  sensitive   = false
}

variable "program" {
  type        = string
  description = "The name of the program that the application or project belongs to"
  sensitive   = false
}

variable "security_group_ids" {
  type        = set(string)
  description = ""
  sensitive   = false
}

variable "subnet_ids" {
  type        = set(string)
  description = ""
  sensitive   = false
}

variable "tls_security_policy" {
  type        = string
  description = ""
  default     = "Policy-Min-TLS-1-2-2019-07"
}

variable "vpc_id" {
  type        = string
  description = ""
  sensitive   = false
}

variable "warm_node_count" {
  type        = number
  description = ""
  default     = 0
  sensitive   = false
}

variable "warm_node_enabled" {
  type        = bool
  description = ""
  default     = false
  sensitive   = false
}

variable "zone_awareness_enabled" {
  type        = bool
  description = ""
  default     = true
  sensitive   = false
}
