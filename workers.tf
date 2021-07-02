////////////////////////////////////////////////////////////////////////////////
// Worker nodes
resource "google_compute_instance" "worker_nodes" {
  count        = var.worker_node_count
  name         = "${var.cluster_name}-worker-${count.index}"
  machine_type = var.worker_node_instance_type
  zone         = var.zone

  // This allows this VM to send traffic from containers without NAT.  Without
  // this set GCE will verify that traffic from a VM only comes from an IP
  // assigned to that VM.
  can_ip_forward = true

  boot_disk {
    initialize_params {
      image = var.os_instance_type
    }
  }

  network_interface {
    network = "default"
    access_config {
      // Ephemeral IP for now
    }
  }
}