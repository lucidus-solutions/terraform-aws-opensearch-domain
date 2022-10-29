resource "aws_opensearch_domain" "this" {
  domain_name    = "${local.stack}-opensearch"
  engine_version = var.engine_version

  cluster_config {
    dedicated_master_count   = var.dedicated_master_count
    dedicated_master_enabled = var.dedicated_master_enabled
    instance_count           = var.data_node_count
    instance_type            = var.data_node_type
    warm_count               = var.warm_node_count
    warm_enabled             = var.warm_node_enabled
    zone_awareness_enabled   = var.zone_awareness_enabled

    cold_storage_options {
      enabled = var.cold_storage_enabled
    }

    zone_awareness_config {
      availability_zone_count = var.zone_awareness_enabled ? 2 : 1
    }
  }

  ebs_options {
    ebs_enabled = var.ebs_enabled
    iops        = var.ebs_iops
    throughput  = var.ebs_throughput
    volume_size = var.ebs_volume_size
    volume_type = var.ebs_volume_type
  }

  advanced_options = {
    "indices.fielddata.cache.size"        = var.indicies_fielddata_cache_size
    "indices.query.bool.max_clause_count" = var.indicies_query_bool_max_clause_count
  }

  vpc_options {
    availability_zones = var.availability_zones
    security_group_ids = var.security_group_ids
    subnet_ids         = var.subnet_ids
    vpc_id             = var.vpc_id
  }

  domain_endpoint_options {
    custom_endpoint_enabled         = var.custom_endpoint_enabled
    enforce_https                   = var.enforce_https
    tls_security_policy             = var.tls_security_policy
    custom_endpoint                 = var.custom_endpoint
    custom_endpoint_certificate_arn = var.custom_endpoint_certificate_arn
  }

  encrypt_at_rest {
    enabled    = var.encrypt_at_rest
    kms_key_id = var.kms_key_id
  }

  node_to_node_encryption {
    enabled = var.node_to_node_encryption
  }

  log_publishing_options {
    enabled                  = var.enable_index_slow_logs
    cloudwatch_log_group_arn = var.enable_slow_logs ? cloudwatch_log_group_arn.index_slow_logs.arn : null
    log_type                 = var.enable_index_slow_logs ? "INDEX_SLOW_LOGS" : null
  }

  log_publishing_options {
    enabled                  = var.enable_search_slow_logs
    cloudwatch_log_group_arn = var.enable_search_slow_logs ? aws_cloudwatch_log_group.search_slow_logs.arn : null
    log_type                 = var.enable_search_slow_logs ? "SEARCH_SLOW_LOGS" : null
  }

  log_publishing_options {
    enabled                  = var.enable_error_logs
    cloudwatch_log_group_arn = var.enable_error_logs ? aws_cloudwatch_log_group.error_logs.arn : null
    log_type                 = var.enable_error_logs ? "ES_APPLICATION_LOGS" : null
  }

  log_publishing_options {
    enabled                  = var.enable_audit_logs
    cloudwatch_log_group_arn = var.enable_audit_logs ? aws_cloudwatch_log_group.audit_logs.arn : null
    log_type                 = var.enable_audit_logs ? "AUDIT_LOGS" : null
  }

  snapshot_options {
    automated_snapshot_start_hour = var.automated_snapshot_start_hour
  }

  auto_tune_options {
    desired_state       = var.autotune_desired_state
    rollback_on_disable = var.autotune_rollback_on_disable

    maintenance_schedule {
      cron_expression_for_recurrence = var.autotune_cron_schedule
      start_at                       = var.autotune_start_datetime

      duration {
        unit  = var.autotune_duration_unit
        value = var.autotune_duration_value
      }
    }
  }

  cognito_options {
    enabled          = var.cognito_enabled
    identity_pool_id = var.cognito_identity_pool_id
    role_arn         = var.cognito_role_arn
    user_pool_id     = var.cognito_user_pool_id
  }
}

resource "aws_cloudwatch_log_group" "audit_logs" {
  name              = "${local.stack}-opensearch-audit-logs"
  retention_in_days = var.audit_log_retention
}

resource "aws_cloudwatch_log_group" "error_logs" {
  name              = "${local.stack}-opensearch-error-logs"
  retention_in_days = var.error_log_retention
}

resource "aws_cloudwatch_log_group" "index_slow_logs" {
  name              = "${local.stack}-opensearch-index-slow-logs"
  retention_in_days = var.index_slow_log_retention
}

resource "aws_cloudwatch_log_group" "search_slow_logs" {
  name              = "${local.stack}-opensearch-search-slow-logs"
  retention_in_days = var.search_slow_log_retention
}

variable "audit_log_retention" {
  type      = number
  default   = 90
  sensitive = false
}

variable "error_log_retention" {
  type        = number
  description = ""
  default     = 90
  sensitive   = false
}

variable "index_slow_log_retention" {
  type        = number
  description = ""
  default     = 90
  sensitive   = false
}

variable "enable_audit_logs" {
  type        = bool
  description = ""
  default     = true
  sensitive   = false
}

variable "enable_error_logs" {
  type        = bool
  description = ""
  default     = true
  sensitive   = false
}

variable "enable_index_slow_logs" {
  type        = bool
  description = ""
  default     = true
  sensitive   = false
}

variable "enable_search_slow_logs" {
  type        = bool
  description = ""
  default     = true
  sensitive   = false
}

# You must have created the service linked role for the OpenSearch service to use vpc_options. 
# If you need to create the service linked role at the same time as the OpenSearch domain then 
# you must use depends_on to make sure that the role is created before the OpenSearch domain