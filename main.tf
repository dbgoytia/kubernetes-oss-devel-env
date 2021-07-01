resource "google_compute_instance" "master_nodes" {
  name         = "master-node"
  machine_type = "e2-medium"
  zone         = "us-central1-a"

  boot_disk {
    initialize_params {
      image = "ubuntu-os-cloud/ubuntu-1804-bionic-v20210623"
    }
  }

  network_interface {
      network = "default"
      access_config {
          // Ephemeral IP for now
      }
  }

}