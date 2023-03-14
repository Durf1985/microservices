output "app_external_ip" {
  description = "Reddit app VM external IP"
  value       = google_compute_instance.reddit_app.network_interface[0].access_config[0].nat_ip
}
