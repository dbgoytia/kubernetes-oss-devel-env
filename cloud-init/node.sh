#!/bin/bash -v

for i in {1..50}; do
  if kubeadm join --token=${token} ${master-ip}:6443 --discovery-token-unsafe-skip-ca-verification; then
    break
  else
    sleep 15
  fi
done