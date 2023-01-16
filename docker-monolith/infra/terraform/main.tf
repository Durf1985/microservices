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

resource "google_compute_instance" "app" {
  name         = "reddit-docker-${count.index + 1}"
  machine_type = "e2-medium"
  zone         = var.zone 
  tags         = ["reddit-docker"]
  boot_disk {
    initialize_params { image = var.app_disk_image } 
  }
  network_interface {
    network = "default"
    access_config {
      nat_ip = google_compute_address.app_ip[count.index].address
    }
  }
  count = var.number_of_instances
  metadata = {
    ssh-keys = "appuser:${file(var.public_key_path)}"
  }
}

resource "google_compute_address" "app_ip" {
  name  = "reddit-docker-ip-${count.index + 1}"
  count = var.number_of_instances
}

resource "google_compute_firewall" "firewall_puma" {
  name    = "docker-puma-default"
  network = "default"
  allow {
    protocol = "tcp"
    ports    = var.app_port
  }
  source_ranges = ["0.0.0.0/0"]
  target_tags   = ["reddit-docker"]
}
