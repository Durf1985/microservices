resource "google_compute_instance" "reddit_app" {
  name         = "reddit-app-${terraform.workspace}"
  machine_type = "e2-standard-2"
  zone         = var.zone
  tags         = ["reddit-app-${terraform.workspace}"]
  boot_disk {
    initialize_params {
      image = var.gitlab_disk_image
      size  = 20
    }
    auto_delete = true
  }
  allow_stopping_for_update = true
  network_interface {
    network = "default"
    access_config {
    }
  }
  metadata = {
    ssh-keys = "appuser:${file(var.public_key_path)}"
  }
}

resource "google_compute_firewall" "reddit_app" {
  name    = "runner-default-${terraform.workspace}"
  network = "default"
  allow {
    protocol = "tcp"
    ports    = ["80", "443", "9292", "2222"]
  }
  source_ranges = ["0.0.0.0/0"]
  target_tags   = ["reddit-app-${terraform.workspace}"]
}
