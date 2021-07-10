provider "google" {
  credentials = file("~/.gcloud-credentials/kubernetes-oss-devel-9b0a02664c68.json")
  project     = "kubernetes-oss-devel"
  region      = var.region
}

terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "~>3.74.0"
    }
  }
  required_version = "~>v0.15.4"
}