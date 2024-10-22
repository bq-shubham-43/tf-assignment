terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "~> 3.90.1" 
    }
  }

  required_version = ">= 0.12"
}
provider "google" {
  project = var.project_id
  region  = var.region
  zone    = var.zone
}

provider "google-beta" {
  project = var.project_id
  region  = var.region
  zone    = var.zone
}
