variable "project" {
  type        = string
  description = "Project ID"
  default = "docker-86505"
}

variable "region" {
  type        = string
  description = "Region"
  default     = "us-central1"
}

variable "public_key_path" {
  type        = string
  description = "Path to the public key used for ssh access"
}
