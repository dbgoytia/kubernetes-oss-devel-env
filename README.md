Kubernetes GCE installation using kubeadm
=========================================

Creates a Kubernetes cluster on GCE using [kubeadm](https://kubernetes.io/docs/setup/production-environment/tools/kubeadm/install-kubeadm/).

Provisions all requirements and configures GCE instances using [cloud-init](https://cloudinit.readthedocs.io/en/latest/topics/format.html#mime-multi-part-archive).

This development environment deploys a Kubernetes cluster to be used for contributing to Kubernetes open source software. I still recommended to use the awesome module built by Joe Beda [here](https://github.com/jbeda/kubeadm-gce-tf/blob/master/master.tf), from which I took most of the ideas, but I think this could be a good alternative. Of course I couldn't pass on taking this challenge and build my own module and learn a little bit more about GCE, cloud init, and Kubernetes in general in the way.  I'd like to think that I'm somehow enhancing that other development and probably empowering new OSS enthusiasts like myself to build their own stuff and learn on the way there.

Some of the advantages of running your own Kubernetes cluster:
* You can run your own CNI, so you can choose whatever fits your needs the best.
* Cost of running your cluster will drop significantly if your team is good with Kubernetes.
* You can have full control of the deployment and configuration of the cluster.
* You get to do all the lifecycle of the cluster

Some disadvantages:
* Your team has to be as experienced as Google SRE's or Amazon TAM's to run this kind of services.
* Your team has to have deep knowledge of all the components that make up the Kubernetes ecosystem.

Some cool resources I've got on the way in learing while building this:
- https://cloudinit.readthedocs.io/en/latest/topics/format.html#mime-multi-part-archive 
- https://github.com/jbeda/kubeadm-gce-tf/blob/master/master.tf
- https://help.ubuntu.com/community/CloudInit Visit this resource if you want to know about the MIME files (still need to do some research about the lifecycle of cloud-init scripts and configurations, I believe this is the technology that empowers - among others - Google [Shielded-vms](https://cloud.google.com/security/shielded-cloud/shielded-vm))
- https://registry.terraform.io/providers/hashicorp/template/latest/docs/data-sources/cloudinit_config as a reference for the cloud init configuration file in Terraform.


Generate a random bootstrap_token for passing to the boostrap_bootstrap_token variable:

```
python -c 'import random; print "%0x.%0x" % (random.SystemRandom().getrandbits(3*8), random.SystemRandom().getrandbits(8*8))'
```