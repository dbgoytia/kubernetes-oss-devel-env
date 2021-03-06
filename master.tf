////////////////////////////////////////////////////////////////////////////////
// Master nodes

// Cloud init template file
data "template_file" "prereqs-master" {
  template = file("cloud-init/prereqs.sh")

  vars = {
    version = "1.20"
    os      = "xUbuntu_18.04"
  }
}

data "template_file" "kubeadm_init" {
  template = file("cloud-init/init-master.sh")

  vars = {
    service-cidr = var.overlay_cidr_range
    token        = var.bootstrap_token
  }
}

// Render cloud-init config
data "template_cloudinit_config" "master" {
  base64_encode = true
  gzip          = true

  # Main cloud-config configuration file.
  part {
    filename     = "scripts/per-instance/10-prereq.sh"
    content_type = "text/x-shellscript"
    content      = data.template_file.prereqs-master.rendered
  }

  # Cluster initialization
  part {
    filename     = "scripts/per-instance/20-init-master.sh"
    content_type = "text/x-shellscript"
    content      = data.template_file.kubeadm_init.rendered
  }
}

// Compute Instance
resource "google_compute_instance" "master_nodes" {
  # count        = var.master_node_count
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
    subnetwork = google_compute_subnetwork.infra_subnet.name
    access_config {
      // Ephemeral IP for now
    }
  }

  metadata = {
    user-data          = data.template_cloudinit_config.master.rendered
    user-data-encoding = "base64"
  }

  tags = ["master"]
}