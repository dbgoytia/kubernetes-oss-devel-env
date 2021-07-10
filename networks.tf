////////////////////////////////////////////////////////////////////////////////
// Networking configuration
resource "google_compute_network" "k8s_network" {
  name                    = "k8s-devel-vpc"
  auto_create_subnetworks = false
}

// Subnet for the cluster to live in
resource "google_compute_subnetwork" "subnet" {
  name          = "${var.cluster_name}-subnet-${var.region}" // Add a subnet here.
  ip_cidr_range = var.ip_cidr_range
  network       = google_compute_network.k8s_network.name
  region        = var.region
}

// Allow SSH (TCP port 22) traffic to reach our VMs on this network.
resource "google_compute_firewall" "firewall-ssh" {
  name    = "${var.cluster_name}-ssh"
  network = google_compute_network.k8s_network.name

  allow {
    protocol = "tcp"
    ports    = ["22"]
  }

  source_ranges = ["0.0.0.0/0"]
}
