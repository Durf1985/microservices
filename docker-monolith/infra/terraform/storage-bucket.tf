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
module "storage-bucket" {
  source   = "SweetOps/storage-bucket/google"
  version  = "0.4.0"
  name     = "dev-ops-study-microservice-26022023"
  location = var.region
  enabled  = true

}
output "storage-bucket_url" {
  value = module.storage-bucket.url
}
