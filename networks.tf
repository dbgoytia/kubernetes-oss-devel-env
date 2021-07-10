////////////////////////////////////////////////////////////////////////////////
// Networking configuration
resource "google_compute_network" "k8s_network" {
  name                    = "k8s-devel-vpc"
  auto_create_subnetworks = false
}

// Firewall rules for the network level
resource "google_compute_subnetwork" "subnet" {
  name          = "${var.cluster_name}-subnet-${var.region}" // Add a subnet here.
  ip_cidr_range = var.ip_cidr_range
  network       = google_compute_network.k8s_network.name
  region        = var.region
}

// Internal firewall rules for master instances
resource "google_compute_firewall" "internal_firewall" {
  name        = "${var.cluster_name}-internal-master"
  network     = google_compute_network.k8s_network.name
  description = "Firewall rules for master nodes"

  target_tags = ["master"]

  allow {
    protocol = "icmp"
  }

  allow {
    protocol = "tcp"
    ports    = ["6443"]
  }

  allow {
    protocol = "tcp"
    ports    = ["2379-2380"]
  }

  allow {
    protocol = "tcp"
    ports    = ["10250-10252"]
  }

  source_ranges = [var.ip_cidr_range]

}

// Internal firewall rules for node instances
resource "google_compute_firewall" "internal_firewall_nodes" {
  name        = "${var.cluster_name}-internal-nodes"
  network     = google_compute_network.k8s_network.name
  description = "Firewall rules for nodes"


  target_tags = ["nodes"]

  allow {
    protocol = "icmp"
  }

  allow {
    protocol = "tcp"
    ports    = ["10250"]
  }

  allow {
    protocol = "tcp"
    ports    = ["30000-32767"]
  }

  source_ranges = [var.ip_cidr_range]

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
