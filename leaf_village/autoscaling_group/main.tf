resource "aws_autoscaling_group" "Application" {
  name = format("%s-asg", var.asg_name)
  launch_template {
    id      = var.launch_template_id
    version = var.template_version
  }
  health_check_grace_period = var.health_check_grace_period
  health_check_type         = var.health_check_type
  min_size                  = var.min_size
  max_size                  = var.max_size
  desired_capacity          = var.desired_size
  vpc_zone_identifier       = var.vpc_zone_identifier_subnet
  target_group_arns         = var.target_group_arns

  dynamic "initial_lifecycle_hook" {
    for_each = var.initial_lifecycle_hook != null ? var.initial_lifecycle_hook : []
    content {
    name                 = initial_lifecycle_hook.value.lifecycle_name
    default_result       = initial_lifecycle_hook.value.default_result
    heartbeat_timeout    = initial_lifecycle_hook.value.heartbeat_timeout
    lifecycle_transition = initial_lifecycle_hook.value.lifecycle_transition
    }
  }
  dynamic traffic_source {
    for_each = var.traffic_source != null ? var.traffic_source : []
    content {
      identifier = traffic_source.value.identifier
      type = traffic_source.value.type
    }
  }
  service_linked_role_arn = var.service_linked_role_arn
  dynamic "tag" {
    for_each = var.extra_tags
    content {
      key                 = tag.value.key
      propagate_at_launch = tag.value.propagate_at_launch
      value               = tag.value.value
    }
  }
}

resource "aws_autoscaling_policy" "scale_up" {
  count                  = var.create_scale_up_policy ? 1 : 0
  name                   = "${var.asg_name}-asg-scale-up"
  policy_type            = var.policy_type_scale_up
  adjustment_type        = var.adjustment_type
  autoscaling_group_name = aws_autoscaling_group.Application.name
  cooldown               = var.cooldown
  scaling_adjustment     = var.scaling_up_adjustment
}

resource "aws_cloudwatch_metric_alarm" "scale_up_alarm" {
  count               = var.create_scale_up_alarm ? 1 : 0
  alarm_name          = "${var.asg_name}-asg-scale-up-alarm"
  alarm_description   = var.alarm_description
  comparison_operator = var.comparison_operator_scale_up
  evaluation_periods  = var.scale_up_evaluation_periods
  metric_name         = var.metric_name
  namespace           = var.namespace
  period              = var.period
  statistic           = var.statistic
  threshold           = var.scale_up_threshold
  dimensions = {
    "AutoScalingGroupName" = aws_autoscaling_group.Application.name
  }
  actions_enabled = true
  alarm_actions   = [aws_autoscaling_policy.scale_up[count.index].arn]
  tags = merge(
    var.comman_tags,
    var.cloudwatch_alarm_tags
  )
}

resource "aws_autoscaling_policy" "scale_down" {
  count                  = var.create_scale_down_policy ? 1 : 0
  name                   = "${var.asg_name}-asg-scale-down"
  autoscaling_group_name = aws_autoscaling_group.Application.name
  adjustment_type        = var.adjustment_type
  scaling_adjustment     = var.scale_down_adjustment
  cooldown               = var.cooldown
  policy_type            = var.policy_type_scale_down
}

resource "aws_cloudwatch_metric_alarm" "scale_down_alarm" {
  count               = var.create_scale_down_alarm ? 1 : 0
  alarm_name          = "${var.asg_name}-asg-scale-down-alarm"
  alarm_description   = var.alarm_description_scale_down
  comparison_operator = var.comparison_operator_scale_down
  evaluation_periods  = var.scale_down_evaluation_periods
  metric_name         = var.metric_name
  namespace           = var.namespace
  period              = var.period
  statistic           = var.statistic
  threshold           = var.scale_down_threshold
  dimensions = {
    "AutoScalingGroupName" = aws_autoscaling_group.Application.name
  }
  actions_enabled = true
  alarm_actions   = [aws_autoscaling_policy.scale_down[count.index].arn]
  tags = merge(
    var.comman_tags,
    var.cloudwatch_alarm_tags
  )
}