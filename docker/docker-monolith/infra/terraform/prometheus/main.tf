terraform {
  required_version = "1.3.2"
  required_providers {
    google = {
      version = "4.0.0"
    }
  }
}

provider "google" {
  project = var.project
  region  = var.region
}

resource "google_compute_firewall" "prometheus" {
  name        = "prometheus-default"
  description = "Allow TCP traffic on port 9090 for Prometheus"
  network     = "default"

  allow {
    protocol = "tcp"
    ports    = ["9090"]
  }

  source_ranges = ["0.0.0.0/0"]

}
resource "google_compute_firewall" "puma" {
  name        = "puma-default"
  description = "Allow TCP traffic on port 9090 for Prometheus"
  network     = "default"

  allow {
    protocol = "tcp"
    ports    = ["9292"]
  }

  source_ranges = ["0.0.0.0/0"]

}
