variable "cluster_name" {
  description = "The name of the OpenSearch cluster."
  type        = string
  default     = "opensearch"
}

variable "cluster_version" {
  description = "The version of OpenSearch to deploy."
  type        = string
  default     = "2.11"
}

variable "cluster_domain" {
  description = "The hosted zone name of the OpenSearch cluster."
  type        = string
}

variable "cluster_domain_private" {
  description = "Indicates whether to create records in a private (true) or public (false) zone"
  type        = bool
  default     = false
}

variable "create_service_role" {
  description = "Indicates whether to create the service-linked role. See https://docs.aws.amazon.com/opensearch-service/latest/developerguide/slr.html"
  type        = bool
  default     = true
}

variable "master_user_arn" {
  description = "The ARN for the master user of the cluster. If not specified, then it defaults to using the IAM user that is making the request."
  type        = string
  default     = ""
}

variable "master_instance_enabled" {
  description = "Indicates whether dedicated master nodes are enabled for the cluster."
  type        = bool
  default     = true
}

variable "master_instance_type" {
  description = "The type of EC2 instances to run for each master node. A list of available instance types can you find at https://aws.amazon.com/en/opensearch-service/pricing/#On-Demand_instance_pricing"
  type        = string
  default     = "r6gd.large.elasticsearch"

  validation {
    condition     = can(regex("^[t3|m3|r3|i3|i2|r6gd|c6g]", var.master_instance_type))
    error_message = "The EC2 master_instance_type must provide a SSD or NVMe-based local storage."
  }
}

variable "master_instance_count" {
  description = "The number of dedicated master nodes in the cluster."
  type        = number
  default     = 3
}

variable "hot_instance_type" {
  description = "The type of EC2 instances to run for each hot node. A list of available instance types can you find at https://aws.amazon.com/en/opensearch-service/pricing/#On-Demand_instance_pricing"
  type        = string
  default     = "r6gd.4xlarge.elasticsearch"

  validation {
    condition     = can(regex("^[t3|m3|r3|i3|i2|r6gd|c6g|or1]", var.hot_instance_type))
    error_message = "The EC2 hot_instance_type must provide a SSD or NVMe-based local storage."
  }
}

variable "hot_instance_count" {
  description = "The number of dedicated hot nodes in the cluster."
  type        = number
  default     = 3
}

variable "warm_instance_enabled" {
  description = "Indicates whether ultrawarm nodes are enabled for the cluster."
  type        = bool
  default     = true
}

variable "warm_instance_type" {
  description = "The type of EC2 instances to run for each warm node. A list of available instance types can you find at https://aws.amazon.com/en/elasticsearch-service/pricing/#UltraWarm_pricing"
  type        = string
  default     = "ultrawarm1.large.elasticsearch"
}

variable "warm_instance_count" {
  description = "The number of dedicated warm nodes in the cluster."
  type        = number
  default     = 3
}

variable "availability_zones" {
  description = "The number of availability zones for the OpenSearch cluster. Valid values: 1, 2 or 3."
  type        = number
  default     = 3
}

variable "vpc_enabled" {
  description = "Indicates whether the cluster is running inside a VPC."
  type        = bool
  default     = false
}

variable "subnet_ids" {
  description = "The list of VPC subnet IDs to use."
  type        = list(string)
  default     = []
}

variable "security_group_ids" {
  description = "The list of VPC security groups IDs to attach."
  type        = list(string)
  default     = []
}

variable "ebs_enabled" {
  description = "Indicates whether attach EBS volumes to the data nodes."
  type        = bool
  default     = false
}

variable "ebs_volume_size" {
  description = "The size of EBS volumes attached to data nodes (in GiB)."
  type        = number
  default     = 10
}

variable "ebs_volume_type" {
  description = "The type of EBS volumes attached to data nodes."
  type        = string
  default     = "gp3"
}

variable "ebs_throughput" {
  description = "The throughput (in MiB/s) of the EBS volumes attached to data nodes. Valid values are between 125 and 1000."
  type        = number
  default     = 125
}

variable "ebs_iops" {
  description = "The baseline input/output (I/O) performance of EBS volumes attached to data nodes."
  type        = number
  default     = 3000
}

variable "encrypt_kms_key_id" {
  description = "The KMS key ID to encrypt the OpenSearch cluster with. If not specified, then it defaults to using the AWS OpenSearch Service KMS key."
  type        = string
  default     = ""
}

variable "saml_enabled" {
  description = "Indicates whether to configure SAML for the OpenSearch dashboard."
  type        = bool
  default     = true
}

variable "saml_subject_key" {
  description = "Element of the SAML assertion to use for username."
  type        = string
  default     = "http://schemas.xmlsoap.org/ws/2005/05/identity/claims/name"
}

variable "saml_roles_key" {
  description = "Element of the SAML assertion to use for backend roles."
  type        = string
  default     = "http://schemas.microsoft.com/ws/2008/06/identity/claims/role"
}

variable "saml_entity_id" {
  description = "The unique Entity ID of the application in SAML Identity Provider."
  type        = string
  default     = ""
}

variable "saml_metadata_content" {
  description = "The metadata of the SAML application in xml format."
  type        = string
  default     = ""
}

variable "saml_session_timeout" {
  description = "Duration of a session in minutes after a user logs in. Default is 60. Maximum value is 1,440."
  type        = number
  default     = 60
}

variable "saml_master_backend_role" {
  description = "This backend role receives full permissions to the cluster, equivalent to a new master role, but can only use those permissions within Dashboards."
  type        = string
  default     = null
}

variable "saml_master_user_name" {
  description = "This username receives full permissions to the cluster, equivalent to a new master user, but can only use those permissions within Dashboards."
  type        = string
  default     = null
}

variable "composable_index_templates" {
  description = "A map of all composable index templates to create."
  type        = map(any)
  default     = {}
}

variable "composable_index_template_files" {
  description = "A set of all composable index template files to create."
  type        = set(string)
  default     = []
}

variable "index_templates" {
  description = "A map of all index templates to create."
  type        = map(any)
  default     = {}
}

variable "index_template_files" {
  description = "A set of all index template files to create."
  type        = set(string)
  default     = []
}

variable "ism_policies" {
  description = "A map of all ISM policies to create."
  type        = map(any)
  default     = {}
}

variable "ism_policy_files" {
  description = "A set of all ISM policy files to create."
  type        = set(string)
  default     = []
}

variable "indices" {
  description = "A map of all indices to create."
  type = map(object({
    number_of_shards                       = optional(number)
    number_of_replicas                     = optional(number)
    refresh_interval                       = optional(string)
    mappings                               = optional(any, {})
    aliases                                = optional(any, {})
    analysis_analyzer                      = optional(string)
    analysis_char_filter                   = optional(string)
    analysis_filter                        = optional(string)
    analysis_normalizer                    = optional(string)
    analysis_tokenizer                     = optional(string)
    analyze_max_token_count                = optional(string)
    auto_expand_replicas                   = optional(string)
    blocks_metadata                        = optional(bool)
    blocks_read                            = optional(bool)
    blocks_read_only                       = optional(bool)
    blocks_read_only_allow_delete          = optional(bool)
    blocks_write                           = optional(bool)
    codec                                  = optional(string)
    default_pipeline                       = optional(string)
    gc_deletes                             = optional(string)
    highlight_max_analyzed_offset          = optional(string)
    include_type_name                      = optional(string)
    index_similarity_default               = optional(string)
    indexing_slowlog_level                 = optional(string)
    indexing_slowlog_source                = optional(string)
    indexing_slowlog_threshold_index_debug = optional(string)
    indexing_slowlog_threshold_index_info  = optional(string)
    indexing_slowlog_threshold_index_trace = optional(string)
    indexing_slowlog_threshold_index_warn  = optional(string)
    load_fixed_bitset_filters_eagerly      = optional(bool)
    max_docvalue_fields_search             = optional(string)
    max_inner_result_window                = optional(string)
    max_ngram_diff                         = optional(string)
    max_refresh_listeners                  = optional(string)
    max_regex_length                       = optional(string)
    max_rescore_window                     = optional(string)
    max_result_window                      = optional(string)
    max_script_fields                      = optional(string)
    max_shingle_diff                       = optional(string)
    max_terms_count                        = optional(string)
    number_of_routing_shards               = optional(string)
    rollover_alias                         = optional(string)
    routing_allocation_enable              = optional(string)
    routing_partition_size                 = optional(string)
    routing_rebalance_enable               = optional(string)
    search_idle_after                      = optional(string)
    search_slowlog_level                   = optional(string)
    search_slowlog_threshold_fetch_info    = optional(string)
    search_slowlog_threshold_fetch_debug   = optional(string)
    search_slowlog_threshold_fetch_trace   = optional(string)
    search_slowlog_threshold_fetch_warn    = optional(string)
    search_slowlog_threshold_query_debug   = optional(string)
    search_slowlog_threshold_query_info    = optional(string)
    search_slowlog_threshold_query_trace   = optional(string)
    search_slowlog_threshold_query_warn    = optional(string)
    shard_check_on_startup                 = optional(string)
    sort_field                             = optional(string)
    sort_order                             = optional(string)
  }))
  default = {}
}

variable "index_files" {
  description = "A set of all index files to create."
  type        = set(string)
  default     = []
}

variable "roles" {
  description = "A map of all roles to create."
  type        = map(any)
  default     = {}
}

variable "role_files" {
  description = "A set of all role files to create."
  type        = set(string)
  default     = []
}

variable "role_mappings" {
  description = "A map of all role mappings to create."
  type        = map(any)
  default     = {}
}

variable "role_mapping_files" {
  description = "A set of all role mapping files to create."
  type        = set(string)
  default     = []
}

variable "tags" {
  description = "A map of tags to add to all resources."
  type        = map(string)
  default     = {}
}

variable "custom_endpoint" {
  description = "Fully qualified domain for your custom endpoint. If not specified, then it defaults to <cluster_name>.<cluster_domain>"
  type        = string
  default     = null
}

variable "custom_endpoint_certificate_arn" {
  description = "The ARN of the custom ACM certificate."
  type        = string
  default     = ""
}

variable "advanced_options" {
  description = "Key-value string pairs to specify advanced configuration options."
  type        = map(string)
  default     = null
}

variable "advanced_security_options_enabled" {
  description = "Whether advanced security is enabled."
  type        = bool
  default     = true
}

variable "cognito_options_enabled" {
  description = "Whether Amazon Cognito authentication with Kibana is enabled or not."
  type        = bool
  default     = false
}

variable "cognito_options" {
  description = "Configuration block for authenticating Kibana with Cognito."
  type        = map(string)
  default     = {}
}

variable "access_policies" {
  description = "IAM policy document specifying the access policies for the domain."
  type        = string
  default     = null
}

variable "advanced_security_options_internal_user_database_enabled" {
  description = "Whether to enable or not internal Kibana user database for ELK OpenDistro security plugin"
  type        = bool
  default     = false
}

variable "advanced_security_options_master_user_name" {
  description = "Master user username (applicable if advanced_security_options_internal_user_database_enabled set to true)"
  type        = string
  default     = null
}

variable "advanced_security_options_master_user_password" {
  description = "Master user password (applicable if advanced_security_options_internal_user_database_enabled set to true)"
  type        = string
  default     = null
}

variable "node_to_node_encryption_enabled" {
  description = "Configuration block for node-to-node encryption options"
  type        = bool
  default     = true
}

variable "encrypt_at_rest_enabled" {
  description = "Configuration block for encrypt at rest options"
  type        = bool
  default     = true
}

variable "auto_tune_enabled" {
  description = "Whether to enable/disable auto-tune"
  type        = bool
  default     = true
}

variable "auto_tune_options" {
  description = "Configuration block for auto-tune options. The maintenance schedule block is required if rollback_on_disable is set to DEFAULT_ROLLBACK. The start_at field must be a time and date in RFC3339 format"
  type = object({
    maintenance_schedule = optional(list(object({
      start_at = string
      duration = object({
        value = number
      })
      cron_expression_for_recurrence = optional(string)
    })))
    rollback_on_disable = string
  })
  default = {
    rollback_on_disable  = "NO_ROLLBACK"
    maintenance_schedule = []
  }
}

variable "log_streams_enabled" {
  description = "Configuration for which log streams to enable sending logs to CloudWatch."
  type        = map(string)
  default = {
    "INDEX_SLOW_LOGS"     = "false"
    "SEARCH_SLOW_LOGS"    = "false"
    "ES_APPLICATION_LOGS" = "false"
    "AUDIT_LOGS"          = "false"
  }
}

variable "custom_vpce" {
  description = "List of VPC endpoints or DNS targets for the CNAME record"
  type        = string
  default     = ""
}

variable "domain_vpce_hosted_zone_id" {
  description = "The AWS hosted zone ID of the VPC endpoint (not our hosted zone)"
  type        = string
  default     = ""
}
