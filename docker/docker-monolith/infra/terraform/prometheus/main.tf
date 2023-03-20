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

resource "google_compute_firewall" "cadvisor" {
  name        = "cadvisor-default"
  description = "Allow TCP traffic on port 8080 for cAdvisor"
  network     = "default"
  allow {
    protocol = "tcp"
    ports    = ["8080"]
  }
  source_ranges = ["0.0.0.0/0"]
}

resource "google_compute_firewall" "grafana" {
  name = "grafana-default"
  description = "Allow TCP traffic on port 3000 for Grafana"
  network = "default"
  allow {
    protocol = "tcp"
    ports = [ "3000" ]
  }
  source_ranges = [ "0.0.0.0/0" ]
}

resource "google_compute_firewall" "alertmanger" {
  name = "alertmanger-default"
  description = "Allow TCP traffic on port 9093 for Alertmanager"
  network = "default"
  allow {
    protocol = "tcp"
    ports = [ "9093" ]
  }
  source_ranges = [ "0.0.0.0/0" ]
}
