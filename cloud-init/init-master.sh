#!/bin/bash -v

kubeadm init --service-cidr=${service-cidr} --token=${token}