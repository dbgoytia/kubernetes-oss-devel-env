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
$ kubectl describe node/oss-contrib-master 
  Ready            False   Fri, 30 Jul 2021 04:52:40 +0000   Fri, 30 Jul 2021 04:52:26 +0000   KubeletNotReady              container runtime network not ready: NetworkReady=false reason:NetworkPluginNotReady message:Network plugin returns error: No CNI configuration file in /etc/cni/net.d/. Has your network provider started?
```

We might want to search around how to implement this using GCE CNI:
https://kubernetes.io/docs/concepts/cluster-administration/networking/#google-compute-engine-gce


Aug 13
======

Found out that you need to add the source IP of your running machine to be able to handle this cluster remotely. Please go ahead and add your IP to the sources list once you're done deploying (or at open up for 0.0.0.0/0 - not recommended).