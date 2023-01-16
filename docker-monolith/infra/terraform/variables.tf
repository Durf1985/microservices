variable "project" {
  type        = string
  description = "Project ID"

}
variable "region" {
  type        = string
  description = "Region"
  default     = "us-central1"
}

variable "zone" {
  type        = string
  description = "Zone"
  default     = "us-central1-a"
}

variable "app_disk_image" {
  type        = string
  description = "Disk image for reddit app"
  default     = "ubuntu-1804-lts"
}

variable "number_of_instances" {
  type        = number
  description = "Count of VM instance"
}
variable "public_key_path" {
  type        = string
  description = "Path to the public key used for ssh access"
}
variable "app_port" {
  type    = list(string)
  default = ["9292"]
}
