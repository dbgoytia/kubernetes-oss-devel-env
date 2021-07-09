////////////////////////////////////////////////////////////////////////////////
// Master nodes

// Cloud init template file
data "template_file" "prereqs" {
  template = file("cloud-init/prereqs.cfg")
}

data "template_cloudinit_config" "master" {
  base64_encode = true
  gzip          = true

  # Main cloud-config configuration file.
  part {
    filename     = "init.cfg"
    content_type = "text/cloud-config"
    content      = data.template_file.prereqs.rendered
  }
}

// Compute Instance
resource "google_compute_instance" "master_nodes" {
  count        = var.master_node_count
  name         = "${var.cluster_name}-master"
  machine_type = var.master_node_instance_type
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

  metadata = {
    user-data          = data.template_cloudinit_config.master.rendered
    user-data-encoding = "base64"
  }
}