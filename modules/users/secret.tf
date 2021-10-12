resource "aws_secretsmanager_secret" "sm" {
  for_each =  var.secrets
  name                    = each.key
  name_prefix             = can(each.value.name_prefix) ? each.value.name_prefix : null
  description             = can(each.value.description) ? each.value.description : null
  kms_key_id              = can(each.value.kms_key_id) ? each.value.kms_key_id : null
  policy                  = can(each.value.policy) ? each.value.policy : null
  recovery_window_in_days = can(each.value.recovery_window_in_days) ? each.value.recovery_window_in_days : 7
  replica {
    region                = can(each.value.replica_region) ? each.value.replica_region : null
  }
  tags                    = can(var.tags) ? var.tags : null 
}

resource "aws_secretsmanager_secret_version" "sm-sv" {
  for_each      = var.secrets
  secret_id     = each.key
  secret_string = jsonencode(each.value.secrets)
  depends_on    = [aws_secretsmanager_secret.sm]
} 