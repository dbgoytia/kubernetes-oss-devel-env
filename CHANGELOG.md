v 0.0.0
========

- [X] Tag the appropiate instances with network tags -> master/node. (Diego).
- [ ] Configure single master and multiple worker node cluster using kubeadm on GCE.
- [ ] Configure multiple master and multiple worker node cluster using kubeadm on GCE.
- [ ] Configures automatically the CNI // Again, deep dive into the alternatives and test them out.
- [ ] Run automatic conformance tests for the clusters.
- [ ] Hardened Firewall rules for the GCP network configuration.
- [ ] Install the XFS driver to the cluster automatically, probably using cloud-init or some other remote-exec Terraform function.
- [ ] Remove this thing from the nodes --discovery-token-unsafe-skip-ca-verification, since it weakens security of the cluster: https://kubernetes.io/docs/reference/setup-tools/kubeadm/kubeadm-join/
 
July, 29
========

Added the capability for nodes to automatically join the control plane. Still need to investigate further if we can stop using --discovery-token-unsafe-skip-ca-verification in the node.sh, doesn't matter really for now. 

Most priority feature to add is the network CNI, right now kubelet is showing this error:

```
$ kubectl get nodes
NAME                   STATUS     ROLES                  AGE     VERSION
oss-contrib-master     NotReady   control-plane,master   2m11s   v1.21.3
oss-contrib-worker-0   NotReady   <none>                 114s    v1.21.3
```

```
  Ready            False   Fri, 30 Jul 2021 04:52:40 +0000   Fri, 30 Jul 2021 04:52:26 +0000   KubeletNotReady              container runtime network not ready: NetworkReady=false reason:NetworkPluginNotReady message:Network plugin returns error: No CNI configuration file in /etc/cni/net.d/. Has your network provider started?
```

We might want to search around how to implement this using GCE CNI:
https://kubernetes.io/docs/concepts/cluster-administration/networking/#google-compute-engine-gce