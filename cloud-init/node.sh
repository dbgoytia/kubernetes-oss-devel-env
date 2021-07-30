#!/bin/bash -v
for i in {1..50}; do
  if kubeadm join --token=${token} ${master-ip} ; then
    break
  else
    sleep 15
  fi
done