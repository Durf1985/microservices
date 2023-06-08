terraform {
  backend "gcs" {
    bucket = "dev-ops-study-microservice-26022023"
    prefix = "terraform/cluster/state"
  }
}
