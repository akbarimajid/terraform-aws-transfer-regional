#resource "aws_cloudwatch_log_metric_filter" "user-activity-metric" {
#  for_each =  var.users
#  name           = "${each.value.alarm_name}-metric-filter"
#  log_group_name = "/aws/lambda/sftp-idp"
#  pattern        = "Username: ${each.value.alarm_name}"
#  metric_transformation {
#    name      = "${each.value.alarm_name}-Activity"
#    namespace = "UserActivityMetrics"
#    value     = "1"
#    default_value = "0"
#  }
#}
#
#resource "aws_cloudwatch_metric_alarm" "user-inactivity-alarm" {
#  for_each =  var.users
#  alarm_name = "${each.value.alarm_name}-metric-alarm"
#  metric_name         = "${each.value.alarm_name}-Activity"
#  threshold           = "1"
#  statistic           = "Sum"
#  comparison_operator = "LessThanThreshold"
#  datapoints_to_alarm = "1"
#  evaluation_periods  = "1"
#  period              = "300"
#  namespace           = "UserActivityMetrics"
#  alarm_actions       = [var.sns_topic_arn]
#
#  tags = {
#    Terraform  = "true"
#    owner      = "majid"
#  }
#}