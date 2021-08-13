#!/bin/bash -v

# Initialize Kubernetes cluster
kubeadm init --service-cidr=${service-cidr} --token=${token}
