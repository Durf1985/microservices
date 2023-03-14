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

variable "zone" {
  type        = string
  description = "Zone"
  default     = "us-central1-b"
}

variable "gitlab_disk_image" {
  type        = string
  description = "Disk image for gitlab-ci"
  default     = "projects/docker-86505/global/images/reddit-docker-2"
}

variable "app_port" {
  type    = list(string)
  default = ["9292"]
}

variable "public_key_path" {
  type        = string
  description = "Path to the public key used for ssh access"
}
