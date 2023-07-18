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


resource "google_service_account" "default" {
  account_id   = "service-account-id"
  display_name = "Service Account"
}

resource "google_container_cluster" "primary" {
  name     = "my-gke-cluster"
  location = var.zone
  
  node_config {
    preemptible  = true
    disk_size_gb = 30
  }

 
  remove_default_node_pool = true
  initial_node_count       = 1
}

resource "google_container_node_pool" "primary_preemptible_nodes" {
  name       = "my-node-pool"
  location   = var.zone
  cluster    = google_container_cluster.primary.name
  node_count = 1

  node_config {
    preemptible  = true
    machine_type = "e2-standard-4"
    disk_size_gb = 30

    # Google recommends custom service accounts that have cloud-platform scope and permissions granted via IAM Roles.
    service_account = google_service_account.default.email
    oauth_scopes    = [
      "https://www.googleapis.com/auth/cloud-platform"
    ]
  }
}
resource "google_compute_address" "gitlab_ip" {
  name   = "gitlab-ip"
  region = "us-central1"
}
# resource "google_compute_disk" "reddit_mongo_disk" {
#   name  = "reddit-mongo-disk"
#   type  = "pd-standard"
#   size  = 25
#   zone  = var.zone
# }
