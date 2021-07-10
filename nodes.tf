////////////////////////////////////////////////////////////////////////////////
// Worker nodes

// Cloud init template file
data "template_file" "prereqs-nodes" {
  template = file("cloud-init/prereqs.sh")

  vars = {
    version = "1.20"
    os      = "xUbuntu_18.04"
  }
}

// Render cloud-init config
data "template_cloudinit_config" "nodes" {
  base64_encode = true
  gzip          = true

  # Main cloud-config configuration file.
  part {
    filename     = "scripts/per-instance/10-prereq.sh"
    content_type = "text/x-shellscript"
    content      = data.template_file.prereqs-nodes.rendered
  }
}

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
    subnetwork = google_compute_subnetwork.subnet.name
    access_config {
      // Ephemeral IP for now
    }
  }

  metadata = {
    user-data          = data.template_cloudinit_config.nodes.rendered
    user-data-encoding = "base64"
  }

  tags = ["nodes"]
}