terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "3.89.0"
    }
    helm = {
      source  = "hashicorp/helm"
      version = "2.3.0"
    }
  }
}

provider "google" {
  credentials = file("${var.credentials}.json")
  project     = var.project_id
  region      = var.region
}