variable "cluster_name" {
  description = "Name of the Kubernetes cluster"
  type        = string
}

variable "region" {
  description = "Zone to deploy the cluster in"
  type        = string
}

variable "zone" {
  description = "Deployment zone of the instances"
  type        = string
}

variable "os_instance_type" {
  description = "Instance type of the OS"
  type        = string
}

variable "ip_cidr_range" {
  description = "The range of IP addresses belonging to this subnetwork secondary range."
  type        = string
}

variable "master_node_count" {
  description = "Number of Kubernetes master nodes to deploy"
  type        = number
  default     = 1

}

variable "master_node_instance_type" {
  description = "Instance type for the master nodes"
  type        = string
}

variable "worker_node_count" {
  description = "Number of Kubernetes worker nodes to deploy"
  type        = number
  default     = 1
}

variable "worker_node_instance_type" {
  description = "Instance type for the master nodes"
  type        = string
}