provider "google" {
  credentials = file("~/.gcloud-credentials/kubernetes-oss-devel-9b0a02664c68.json")
  project     = "kubernetes-oss-devel"
  region      = "us-central-1"
}