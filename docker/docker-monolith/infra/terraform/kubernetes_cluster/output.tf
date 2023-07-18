output "gitlab_ip" {
  value = google_compute_address.gitlab_ip.address
  description = "The static IP Address for Gitlab"
}
