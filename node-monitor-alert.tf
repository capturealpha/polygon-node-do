resource "digitalocean_monitor_alert" "cpu_alert" {
  alerts {
    email = [var.alert_email]
    slack {
      channel = var.alert_slack_channel
      url     = var.alert_slack_webhook
    }
  }
  window      = "5m"
  type        = "v1/insights/droplet/cpu"
  compare     = "GreaterThan"
  value       = var.alert_cpu_threshold
  enabled     = true
  entities    = [digitalocean_droplet.polygon.id]
  description = "CPU usage percentage threshold exceeded"
}