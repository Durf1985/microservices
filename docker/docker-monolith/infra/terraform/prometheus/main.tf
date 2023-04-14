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
resource "google_compute_firewall" "consul" {
  name = "consul-default"
  description = "Allow TCP traffic on port 8500 for Consul"
  network = "default"
  allow {
    protocol = "tcp"
    ports = [ "8500" ]
  }
  source_ranges = [ "0.0.0.0/0" ]
}
resource "google_compute_firewall" "telegraf" {
  name = "telegraf-default"
  description = "Allow TCP traffic on port 9273 for Telegraf"
  network = "default"
  allow {
    protocol = "tcp"
    ports = [ "9273" ]
  }
  source_ranges = [ "0.0.0.0/0" ]
}

resource "google_compute_firewall" "logging" {
  name = "logging-default"
  description = "Allow TCP trafic on port 5601 and 9411 for logging VM"
  network = "default"
  allow {
    protocol = "tcp"
    ports = [ "5601", "9411" ]
  }
  source_ranges = [ "0.0.0.0/0" ]
}

resource "google_compute_firewall" "fluentd" {
  name = "fluentd-default"
  description = "Allow TCP trafic on port 24224:24224"
  network = "default"
  allow {
    protocol = "tcp"
    ports = [ "24224" ]
  }
  source_ranges = [ "0.0.0.0/0" ]
}

resource "google_compute_firewall" "elastic" {
  name = "elastic-default"
  description = "Allow TCP trafic on port 9200"
  network = "default"
  allow {
    protocol = "tcp"
    ports = [ "9200" ]
  }
  source_ranges = [ "0.0.0.0/0" ]

}

resource "google_compute_firewall" "zipkin" {
  name = "zipkin-default"
  description = "Allow TCP trafic on port 9411"
  network = "default"
  allow {
    protocol = "tcp"
    ports = [ "9411" ]
  }
  source_ranges = [ "0.0.0.0/0" ]

}
resource "google_compute_firewall" "post" {
  name = "post-default"
  description = "Allow TCP trafic on port 5000"
  network = "default"
  allow {
    protocol = "tcp"
    ports = [ "5000" ]
  }
  source_ranges = [ "0.0.0.0/0" ]

}
resource "google_compute_firewall" "mongo" {
  name = "mongo-default"
  description = "Allow TCP trafic on port 27017"
  network = "default"
  allow {
    protocol = "tcp"
    ports = [ "27017" ]
  }
  source_ranges = [ "0.0.0.0/0" ]

}
