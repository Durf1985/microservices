terraform {
  required_version = "1.3.2"
  required_providers {
    google = {
      version = "4.0.0"
    }
  }
}

provider "google" {
  project     = var.project
  region      = var.region
}

module "app" {
  source = "../modules/app"
  public_key_path = var.public_key_path
}
