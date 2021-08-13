v 0.0.0
========

- [X] Tag the appropiate instances with network tags -> master/node.
- [ ] Configure single master and multiple worker node cluster using kubeadm on GCE.
- [ ] Configure multiple master and multiple worker node cluster using kubeadm on GCE.
- [ ] Configures automatically the CNI // Again, deep dive into the alternatives and test them out.
- [ ] Run automatic conformance tests for the clusters.
- [ ] Hardened Firewall rules for the GCP network configuration.
- [ ] Install the XFS driver to the cluster automatically, probably using cloud-init or some other remote-exec Terraform function.
- [ ] Remove this thing from the nodes --discovery-token-unsafe-skip-ca-verification, since it weakens security of the cluster: https://kubernetes.io/docs/reference/setup-tools/kubeadm/kubeadm-join/
 
