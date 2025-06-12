variable "env" {
  description = "Ambiente: prod ou stage"
  type        = string
}

variable "project_id" {
  type = string
}

variable "region" {
  default = "us-central1"
}

variable "zone" {
  default = "us-central1-a"
}

variable "machine_type" {
  default = "e2-medium"
}

variable "credentials_file_path" {
  type = string
}
