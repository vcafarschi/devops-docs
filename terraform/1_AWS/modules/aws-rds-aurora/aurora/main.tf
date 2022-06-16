terraform {
  required_version = ">= 1.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "= 3.63.0"
    }
  }
}


locals {
  create_cluster = var.create_cluster
  port = coalesce(var.port, (var.engine == "aurora-postgresql" ? 5432 : 3306))

  # assert_db_subnet_group_name   = var.create_db_subnet_group == false && (var.db_subnet_group_name == "" || var.db_subnet_group_name == null ) ? file("\n\n\n[ERROR] WHEN USING  'create_db_subnet_group = false', PARAMETER 'db_subnet_group_name' IS MANDATORY\n\n\n") : false
  db_subnet_group_name          = coalesce(var.db_subnet_group_name, var.name)
  db_subnet_group_name_elected  = var.create_db_subnet_group ? aws_db_subnet_group.this[0].name : local.db_subnet_group_name

  db_cluster_parameter_group_name            = coalesce(var.db_cluster_parameter_group_name, var.name)
  db_cluster_parameter_group_name_elected    = var.create_cluster_parameter_group ? aws_rds_cluster_parameter_group.this[0].name : local.db_cluster_parameter_group_name

  db_instance_parameter_group_name            = coalesce(var.db_instance_parameter_group_name, var.name)
  db_instance_parameter_group_name_elected    = var.create_instance_db_parameter_group ? aws_db_parameter_group.this[0].name : local.db_instance_parameter_group_name

  rds_security_group_id       = var.create_security_group ? aws_security_group.this[0].id : var.existing_security_group_id

  master_password               = local.create_cluster && var.create_random_password ? random_password.master_password[0].result : var.master_password
  backtrack_window              = (var.engine == "aurora-mysql" || var.engine == "aurora") && var.engine_mode != "serverless" ? var.backtrack_window : 0

  # rds_enhanced_monitoring_arn = var.create_monitoring_role ? join("", aws_iam_role.rds_enhanced_monitoring.*.arn) : var.monitoring_role_arn
  is_serverless               = var.engine_mode == "serverless"
}

#################################################################################
# Data
#################################################################################
data "aws_partition" "current" {} # Ref. https://docs.aws.amazon.com/general/latest/gr/aws-arns-and-namespaces.html#genref-aws-service-namespaces
# Get the current AWS region
data "aws_region" "current" {}


################################################################################
# Random string to use as master password
################################################################################
resource "random_password" "master_password" {
  count = local.create_cluster && var.create_random_password ? 1 : 0

  length  = var.random_password_length
  special = false
}

resource "random_id" "snapshot_identifier" {
  count = local.create_cluster ? 1 : 0

  keepers = {
    id = var.name
  }

  byte_length = 4
}

################################################################################
# Database Subnet group
################################################################################
resource "aws_db_subnet_group" "this" {
  count = local.create_cluster && var.create_db_subnet_group ? 1 : 0

  name        = local.db_subnet_group_name
  description = "For Aurora cluster ${var.name}"
  subnet_ids  = var.subnet_ids

  tags = var.tags
}


################################################################################
# Cluster Parameter Group
################################################################################
resource "aws_rds_cluster_parameter_group" "this" {
  count = local.create_cluster && var.create_cluster_parameter_group ? 1 : 0

  name        = local.db_cluster_parameter_group_name
  # name_prefix = var.use_name_prefix ? "${var.name}-" : null
  family      = var.parameter_group_family
  description = "${var.name} cluster-parameter-group for ${var.parameter_group_family}"

  dynamic "parameter" {
    for_each = var.cluster_parameters
    content {
      name         = parameter.value.name
      value        = parameter.value.value
      apply_method = lookup(parameter.value, "apply_method", null)
    }
  }

  tags = merge(var.tags, var.cluster_tags)

  # lifecycle {
  #   create_before_destroy = true
  # }
}

################################################################################
# Database Instance Parameter Group
################################################################################
resource "aws_db_parameter_group" "this" {
  count = local.create_cluster && var.create_instance_db_parameter_group ? 1 : 0

  name        = local.db_instance_parameter_group_name
  family      = var.parameter_group_family
  description = "${var.name} instance-parameter-group for ${var.parameter_group_family}"

  dynamic "parameter" {
    for_each = var.instance_parameters
    content {
      name         = parameter.value.name
      value        = parameter.value.value
      apply_method = lookup(parameter.value, "apply_method", null)
    }
  }

  tags = merge(var.tags, var.cluster_tags)
}

################################################################################
# Security Group
################################################################################
resource "aws_security_group" "this" {
  count = local.create_cluster && var.create_security_group ? 1 : 0

  name        = var.security_group_use_name_prefix ? null : var.name
  name_prefix = var.security_group_use_name_prefix ? "${var.name}-" : null
  vpc_id      = var.vpc_id
  description = coalesce(var.security_group_description, "Control traffic to/from RDS Aurora ${var.name}")

  tags = merge(var.tags, var.security_group_tags, { Name = var.name })
}

# TODO - change to map of ingress rules under one resource at next breaking change
resource "aws_security_group_rule" "ingress_from_security_group" {
  count = local.create_cluster && var.create_security_group ? length(var.allowed_security_groups) : 0

  description = "From allowed SGs"

  type                     = "ingress"
  from_port                = local.port
  to_port                  = local.port
  protocol                 = "tcp"
  source_security_group_id = element(var.allowed_security_groups, count.index)
  security_group_id        = aws_security_group.this[0].id
}

# TODO - change to map of ingress rules under one resource at next breaking change
resource "aws_security_group_rule" "ingress_from_cidr_blocks" {
  count = local.create_cluster && var.create_security_group && length(var.allowed_cidr_blocks) > 0 ? 1 : 0

  description = "From allowed CIDRs"

  type              = "ingress"
  from_port         = local.port
  to_port           = local.port
  protocol          = "tcp"
  cidr_blocks       = var.allowed_cidr_blocks
  security_group_id = aws_security_group.this[0].id
}

resource "aws_security_group_rule" "egress" {
  for_each = local.create_cluster && var.create_security_group ? var.security_group_egress_rules : {}

  # required
  type              = "egress"
  from_port         = lookup(each.value, "from_port", local.port)
  to_port           = lookup(each.value, "to_port", local.port)
  protocol          = "tcp"
  security_group_id = aws_security_group.this[0].id

  # optional
  cidr_blocks              = lookup(each.value, "cidr_blocks", null)
  description              = lookup(each.value, "description", null)
  ipv6_cidr_blocks         = lookup(each.value, "ipv6_cidr_blocks", null)
  prefix_list_ids          = lookup(each.value, "prefix_list_ids", null)
  source_security_group_id = lookup(each.value, "source_security_group_id", null)
}

################################################################################
# Aurora RDS Cluster
################################################################################
resource "aws_rds_cluster" "this" {
  count = local.create_cluster ? 1 : 0

  # Notes:
  # iam_roles has been removed from this resource and instead will be used with aws_rds_cluster_role_association below to avoid conflicts per docs

  global_cluster_identifier      = var.global_cluster_identifier
  enable_global_write_forwarding = var.enable_global_write_forwarding
  cluster_identifier             = var.name
  replication_source_identifier  = var.replication_source_identifier
  source_region                  = var.source_region

  engine                              = var.engine
  engine_mode                         = var.engine_mode
  engine_version                      = local.is_serverless ? null : var.engine_version

  allow_major_version_upgrade         = var.allow_major_version_upgrade
  enable_http_endpoint                = var.enable_http_endpoint
  # kms_key_id                          = var.kms_key_id
  database_name                       = var.is_primary_cluster ? var.database_name : null
  master_username                     = var.is_primary_cluster ? var.master_username : null
  master_password                     = var.is_primary_cluster ? local.master_password : null
  final_snapshot_identifier           = "${var.final_snapshot_identifier_prefix}-${var.name}-${element(concat(random_id.snapshot_identifier.*.hex, [""]), 0)}"
  skip_final_snapshot                 = var.skip_final_snapshot
  deletion_protection                 = var.deletion_protection
  backup_retention_period             = var.backup_retention_period
  preferred_backup_window             = local.is_serverless ? null : var.preferred_backup_window
  preferred_maintenance_window        = local.is_serverless ? null : var.preferred_maintenance_window
  port                                = local.port
  snapshot_identifier                 = var.snapshot_identifier
  storage_encrypted                   = var.storage_encrypted
  apply_immediately                   = var.apply_immediately

  db_subnet_group_name                = local.db_subnet_group_name_elected

  db_cluster_parameter_group_name     = local.db_cluster_parameter_group_name_elected
  db_instance_parameter_group_name    = var.allow_major_version_upgrade ? local.db_instance_parameter_group_name_elected : null

  # vpc_security_group_ids              = compact(concat(aws_security_group.this.*.id, var.vpc_security_group_ids))
  vpc_security_group_ids              = [local.rds_security_group_id]

  iam_database_authentication_enabled = var.iam_database_authentication_enabled
  backtrack_window                    = local.backtrack_window
  copy_tags_to_snapshot               = var.copy_tags_to_snapshot
  enabled_cloudwatch_logs_exports     = var.enabled_cloudwatch_logs_exports

  timeouts {
    create = lookup(var.cluster_timeouts, "create", null)
    update = lookup(var.cluster_timeouts, "update", null)
    delete = lookup(var.cluster_timeouts, "delete", null)
  }

  dynamic "scaling_configuration" {
    for_each = length(keys(var.scaling_configuration)) == 0 || !local.is_serverless ? [] : [var.scaling_configuration]

    content {
      auto_pause               = lookup(scaling_configuration.value, "auto_pause", null)
      max_capacity             = lookup(scaling_configuration.value, "max_capacity", null)
      min_capacity             = lookup(scaling_configuration.value, "min_capacity", null)
      seconds_until_auto_pause = lookup(scaling_configuration.value, "seconds_until_auto_pause", null)
      timeout_action           = lookup(scaling_configuration.value, "timeout_action", null)
    }
  }

  # dynamic "serverlessv2_scaling_configuration" {
  #   for_each = length(keys(var.serverlessv2_scaling_configuration)) == 0 || local.is_serverless ? [] : [var.serverlessv2_scaling_configuration]

  #   content {
  #     max_capacity = serverlessv2_scaling_configuration.value.max_capacity
  #     min_capacity = serverlessv2_scaling_configuration.value.min_capacity
  #   }
  # }

  dynamic "s3_import" {
    for_each = var.s3_import != null && !local.is_serverless ? [var.s3_import] : []
    content {
      source_engine         = "mysql"
      source_engine_version = s3_import.value.source_engine_version
      bucket_name           = s3_import.value.bucket_name
      bucket_prefix         = lookup(s3_import.value, "bucket_prefix", null)
      ingestion_role        = s3_import.value.ingestion_role
    }
  }

  dynamic "restore_to_point_in_time" {
    for_each = length(keys(var.restore_to_point_in_time)) == 0 ? [] : [var.restore_to_point_in_time]

    content {
      source_cluster_identifier  = restore_to_point_in_time.value.source_cluster_identifier
      restore_type               = lookup(restore_to_point_in_time.value, "restore_type", null)
      use_latest_restorable_time = lookup(restore_to_point_in_time.value, "use_latest_restorable_time", null)
      restore_to_time            = lookup(restore_to_point_in_time.value, "restore_to_time", null)
    }
  }

  lifecycle {
    ignore_changes = [
      # See https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/rds_cluster#replication_source_identifier
      # Since this is used either in read-replica clusters or global clusters, this should be acceptable to specify
      replication_source_identifier,
      # See docs here https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/rds_global_cluster#new-global-cluster-from-existing-db-cluster
      global_cluster_identifier,
    ]
  }

  depends_on = [
    aws_db_subnet_group.this
  ]

  tags = merge(var.tags, var.cluster_tags)
}

################################################################################
# Aurora Cluster Instance
################################################################################
resource "aws_rds_cluster_instance" "this" {
  for_each = local.create_cluster && !local.is_serverless ? var.instances : {}

  # Notes:
  # Do not set preferred_backup_window - its set at the cluster level and will error if provided here

  identifier                            = var.instances_use_identifier_prefix ? null : lookup(each.value, "identifier", "${var.name}-${each.key}")
  identifier_prefix                     = var.instances_use_identifier_prefix ? lookup(each.value, "identifier_prefix", "${var.name}-${each.key}-") : null
  cluster_identifier                    = try(aws_rds_cluster.this[0].id, "")

  engine                                = var.engine
  engine_version                        = var.engine_version
  instance_class                        = lookup(each.value, "instance_class", var.instance_class)

  db_subnet_group_name                  = local.db_subnet_group_name_elected
  db_parameter_group_name               = lookup(each.value, "db_parameter_group_name", local.db_instance_parameter_group_name_elected)

  # monitoring_role_arn                   = local.rds_enhanced_monitoring_arn
  # monitoring_interval                   = lookup(each.value, "monitoring_interval", var.monitoring_interval)

  promotion_tier                        = lookup(each.value, "promotion_tier", null)
  availability_zone                     = lookup(each.value, "availability_zone", null)
  preferred_maintenance_window          = lookup(each.value, "preferred_maintenance_window", var.preferred_maintenance_window)
  auto_minor_version_upgrade            = lookup(each.value, "auto_minor_version_upgrade", var.auto_minor_version_upgrade)

  performance_insights_enabled          = lookup(each.value, "performance_insights_enabled", var.performance_insights_enabled)
  performance_insights_kms_key_id       = lookup(each.value, "performance_insights_kms_key_id", var.performance_insights_kms_key_id)
  performance_insights_retention_period = lookup(each.value, "performance_insights_retention_period", var.performance_insights_retention_period)

  copy_tags_to_snapshot                 = lookup(each.value, "copy_tags_to_snapshot", var.copy_tags_to_snapshot)
  ca_cert_identifier                    = var.ca_cert_identifier
  apply_immediately                     = lookup(each.value, "apply_immediately", var.apply_immediately)
  publicly_accessible                   = lookup(each.value, "publicly_accessible", var.publicly_accessible)

  timeouts {
    create = lookup(var.instance_timeouts, "create", null)
    update = lookup(var.instance_timeouts, "update", null)
    delete = lookup(var.instance_timeouts, "delete", null)
  }

  # TODO - not sure why this is failing and throwing type mis-match errors
  # tags = merge(var.tags, lookup(each.value, "tags", {}))
  tags = var.tags

  depends_on = [aws_rds_cluster.this]
}

################################################################################
# Cluster Endpoint
################################################################################

################################################################################
# Autoscaling
################################################################################


################################################################################
# Enhanced Monitoring
################################################################################