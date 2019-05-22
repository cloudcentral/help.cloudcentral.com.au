---
title: Manage Container Infrastructure using the CLI
tags: [cli, container_infra]
keywords: cli, container_infra
last_updated: May 20, 2019
summary: "How to manage Container Infrastructure using the CLI"
sidebar: cloud_sidebar
permalink: cloud_cli_container_infrastructure.html
folder: cloud
---

## Kubernetes
Kubernetes uses a range of terminology that we refer to in this guide. We define these common terms for your reference:

**Pod**

When using the Kubernetes container orchestration engine, a pod is the smallest deployable unit that can be created and managed. A pod is a co-located group of application containers that run with a shared context. When using Magnum, pods are created and managed within clusters. Refer to the pods section in the Kubernetes User Guide for more information.

**Replication controller**

A replication controller is used to ensure that at any given time a certain number of replicas of a pod are running. Pods are automatically created and deleted by the replication controller as necessary based on a template to ensure that the defined number of replicas exist. Refer to the replication controller section in the Kubernetes User Guide for more information.

**Service**

A service is an additional layer of abstraction provided by the Kubernetes container orchestration engine which defines a logical set of pods and a policy for accessing them. This is useful because pods are created and deleted by a replication controller, for example, other pods needing to discover them can do so via the service abstraction. Refer to the services section in the Kubernetes User Guide for more information.  When Magnum deploys a Kubernetes cluster, it uses parameters defined in the ClusterTemplate and specified on the cluster-create command, for example:

```sh
openstack coe cluster template create k8s-cluster-template \ --image fedora-atomic-latest \
--keypair testkey \ --external-network public \ --dns-nameserver 8.8.8.8 \
--flavor m1.small \ --docker-volume-size 5 \ --network-driver flannel \ --coe
kubernetes

openstack coe cluster create k8s-cluster \ --cluster-template
k8s-cluster-template \ --master-count 3 \ --node-count 8
```

Refer to the ClusterTemplate and Cluster sections for the full list of parameters. Following are further details relevant to a Kubernetes cluster:

**Number of masters (master-count)**

Specified in the cluster-create command to
indicate how many servers will run as master in the cluster. Having more than
one will provide high availability. The masters will be in a load balancer pool
and the virtual IP address (VIP) of the load balancer will serve as the
Kubernetes API endpoint. For external access, a floating IP associated with
this VIP is available and this is the endpoint shown for Kubernetes in the
‘cluster-show’ command.

**Number of nodes (node-count)**

Specified in the
cluster-create command to indicate how many servers will run as node in the
cluster to host the users’ pods. The nodes are registered in Kubernetes using
the Nova instance name.

**Network driver (network-driver)**

Specified in the
ClusterTemplate to select the network driver. The supported and default network
driver is ‘flannel’, an overlay network providing a flat network for all pods.
Refer to the Networking section for more details.

**Volume driver (volume-driver)**

Specified in the ClusterTemplate to select the volume driver.
The supported volume driver is ‘cinder’, allowing Cinder volumes to be mounted
in containers for use as persistent storage. Data written to these volumes will
persist after the container exits and can be accessed again from other
containers, while data written to the union file system hosting the container
will be deleted. Refer to the Storage section for more details.

**Storage driver (docker-storage-driver)**

Specified in the ClusterTemplate to select the
Docker storage driver. The default is ‘devicemapper’. Refer to the Storage
section for more details.

**Image (image)**

Specified in the ClusterTemplate
to indicate the image to boot the servers. The image binary is loaded in Glance
with the attribute ‘os_distro = fedora-atomic’. Current supported images are
Fedora Atomic (download from Fedora ) and CoreOS (download from CoreOS )

**TLS (tls-disabled)**

Transport Layer Security is enabled by default, so you need a
key and signed certificate to access the Kubernetes API and CLI. Magnum handles
its own key and certificate when interfacing with the Kubernetes cluster. In
development mode, TLS can be disabled. Refer to the ‘Transport Layer Security’
section for more details.

### What runs on the servers

The servers for Kubernetes master host containers
in the ‘kube-system’ name space to run the Kubernetes proxy, scheduler and
controller manager. The masters will not host users’ pods. Kubernetes API
server, docker daemon, etcd and flannel run as systemd services. The servers
for Kubernetes node also host a container in the ‘kube-system’ name space to
run the Kubernetes proxy, while Kubernetes kubelet, docker daemon and flannel
run as systemd services.  ### Log into the servers You can log into the master
servers using the login ‘fedora’ and the keypair specified in the
ClusterTemplate.  In addition to the common attributes in the ClusterTemplate,
you can specify the following attributes that are specific to Kubernetes by
using the labels attribute.

**admission_control_list**

This label corresponds to Kubernetes parameter for
the API server ‘–admission-control’. For more details, refer to the Admission
Controllers. The default value corresponds to the one recommended in this doc
for our current Kubernetes version.

**etcd_volume_size**

This label sets the
size of a volume holding the etcd storage data. The default value is 0, meaning
the etcd data is not persisted (no volume).

**container_infra_prefix**

Prefix
of all container images used in the cluster (kubernetes components, coredns,
kubernetes-dashboard, node-exporter). For example, kubernetes-apiserver is
pulled from docker.io/openstackmagnum/kubernetes-apiserver, with this label it
can be changed to myregistry.example.com/mycloud/kubernetes-apiserver.
Similarly, all other components used in the cluster will be prefixed with this
label, which assumes an operator has cloned all expected images in
myregistry.example.com/mycloud. Images that must be mirrored:

* docker.io/coredns/coredns:011
* docker.io/grafana/grafana:latest
* docker.io/openstackmagnum/kubernetes-apiserver
* docker.io/openstackmagnum/kubernetes-controller-manager
* docker.io/openstackmagnum/kubernetes-kubelet
* docker.io/openstackmagnum/kubernetes-proxy
* docker.io/openstackmagnum/kubernetes-scheduler
* docker.io/openstackmagnum/etcd
* docker.io/openstackmagnum/flannel
* docker.io/prom/node-exporter:latest
* docker.io/prom/prometheus:latest
* gcr.io/google_containers/kubernetes-dashboard-amd64:v1.5.1
* gcr.io/google_containers/pause:3.0

**kube_tag**

This label allows users to
select a specific Kubernetes release, based on its container tag. If unset, the
current Magnum version’s default Kubernetes release is installed.
**cloud_provider_tag**

This label allows users to select a specific release for
the openstack cloud provider. If unset, the current Magnum version’s default
kubernetes/cloud-provider-openstack release is installed. For version
compatibility, please consult the release page of the cloud-provider. The
images are hosted here. Stein default: v0.2.0

**etcd_tag**

This label allows
users to select a specific etcd version, based on its container tag. If unset,
the current Magnum version’s a default etcd version. For queens, v3.2.7

**flannel_tag**

This label allows users to select a specific flannel version,
based on its container tag. If unset, the current Magnum version’s a default
flannel version. For queens, v0.9.0 kube_dashboard_enabled
This label triggers the deployment of the kubernetes dashboard. The default value is 1, meaning it will be enabled.

**cert_manager_api**

This label enables the kubernetes certificate manager api.

**kubelet_options**

This label can hold any additional options to be passed to the kubelet. For more details, refer to the kubelet admin guide. By default no additional options are passed.

**kubeproxy_options**

This label can hold any additional options to be passed to the kube proxy. For more details, refer to the kube proxy admin guide. By default no additional options are passed.

**kubecontroller_options**

This label can hold any additional options to be passed to the kube controller manager. For more details, refer to the kube controller manager admin guide. By default no additional options are passed.

**kubeapi_options**

This label can hold any additional options to be passed to the kube api server. For more details, refer to the kube api admin guide. By default no additional options are passed.

**kubescheduler_options**

This label can hold any additional options to be passed to the kube scheduler. For more details, refer to the kube scheduler admin guide. By default no additional options are passed.

**influx_grafana_dashboard_enabled**

The kubernetes dashboard comes with heapster enabled. If this label is set, an influxdb and grafana instance will be deployed, heapster will push data to influx and grafana will project them.

**cgroup_driver**

This label tells kubelet which Cgroup driver to use. Ideally this should be identical to the Cgroup driver that Docker has been started with.

**cloud_provider_enabled**

Add ‘cloud_provider_enabled’ label for the k8s_fedora_atomic driver. Defaults to true. For specific kubernetes versions if ‘cinder’ is selected as a ‘volume_driver’, it is implied that the cloud provider will be enabled since they are combined.

### External load balancer for services
All Kubernetes pods and services created in the cluster are assigned IP addresses on a private container network so they can access each other and the external internet. However, these IP addresses are not accessible from an external network.

To publish a service endpoint externally so that the service can be accessed from the external network, Kubernetes provides the external load balancer feature. This is done by simply specifying in the service manifest the attribute “type: LoadBalancer”. Magnum enables and configures the Kubernetes plugin for OpenStack so that it can interface with Neutron and manage the necessary networking resources.

When the service is created, Kubernetes will add an external load balancer in front of the service so that the service will have an external IP address in addition to the internal IP address on the container network. The service endpoint can then be accessed with this external IP address. Kubernetes handles all the life cycle operations when pods are modified behind the service and when the service is deleted.

Refer to the Kubernetes External Load Balancer section for more details.

### Ingress Controller
In addition to the LoadBalancer described above, Kubernetes can also be configured with an Ingress Controller. Ingress can provide load balancing, SSL termination and name-based virtual hosting.

Magnum allows selecting one of multiple controller options via the ‘ingress_controller’ label. Check the Kubernetes documentation to define your own Ingress resources.

**ingress_controller**

This label sets the Ingress Controller to be used. Currently only traefik is supported. The default is ‘’, meaning no Ingress Controller configured.

**ingress_controller_role**

This label defines the role nodes should have to run an instance of the Ingress Controller. This gives operators full control on which nodes should be running an instance of the controller, and should be set in multiple nodes for availability. Default is ‘ingress’. An example of setting this in a Kubernetes node would be:

```sh
kubectl label node <node-name> role=ingress
```
### DNS
CoreDNS is a critical service in Kubernetes cluster for service discovery. To get high availability for CoreDNS pod for Kubernetes cluster, now Magnum supports the autoscaling of CoreDNS using cluster-proportional-autoscaler. With cluster-proportional-autoscaler, the replicas of CoreDNS pod will be autoscaled based on the nodes and cores in the clsuter to prevent single point failure.

The scaling parameters and data points are provided via a ConfigMap to the autoscaler and it refreshes its parameters table every poll interval to be up to date with the latest desired scaling parameters. Using ConfigMap means user can do on-the-fly changes(including control mode) without rebuilding or restarting the scaler containers/pods. Please refer Autoscale the DNS Service in a Cluster for more info.

## Swarm
A Swarm cluster is a pool of servers running Docker daemon that is managed as a single Docker host. One or more Swarm managers accepts the standard Docker API and manage this pool of servers. Magnum deploys a Swarm cluster using parameters defined in the ClusterTemplate and specified on the ‘cluster-create’ command, for example:
```sh
openstack coe cluster template create swarm-cluster-template \
                           --image fedora-atomic-latest \
                           --keypair testkey \
                           --external-network public \
                           --dns-nameserver 8.8.8.8 \
                           --flavor m1.small \
                           --docker-volume-size 5 \
                           --coe swarm

openstack coe cluster create swarm-cluster \
                  --cluster-template swarm-cluster-template \
                  --master-count 3 \
                  --node-count 8
```
Refer to the ClusterTemplate and Cluster sections for the full list of parameters. Following are further details relevant to Swarm:

### What runs on the servers
There are two types of servers in the Swarm cluster: managers and nodes. The Docker daemon runs on all servers. On the servers for manager, the Swarm manager is run as a Docker container on port 2376 and this is initiated by the systemd service swarm-manager. Etcd is also run on the manager servers for discovery of the node servers in the cluster. On the servers for node, the Swarm agent is run as a Docker container on port 2375 and this is initiated by the systemd service swarm-agent. On start up, the agents will register themselves in etcd and the managers will discover the new node to manage.

**Number of managers (master-count)**

Specified in the cluster-create command to indicate how many servers will run as managers in the cluster. Having more than one will provide high availability. The managers will be in a load balancer pool and the load balancer virtual IP address (VIP) will serve as the Swarm API endpoint. A floating IP associated with the load balancer VIP will serve as the external Swarm API endpoint. The managers accept the standard Docker API and perform the corresponding operation on the servers in the pool. For instance, when a new container is created, the managers will select one of the servers based on some strategy and schedule the containers there.

**Number of nodes (node-count)**

Specified in the cluster-create command to indicate how many servers will run as nodes in the cluster to host your Docker containers. These servers will register themselves in etcd for discovery by the managers, and interact with the managers. Docker daemon is run locally to host containers from users.

**Network driver (network-driver)**

Specified in the ClusterTemplate to select the network driver. The supported drivers are ‘docker’ and ‘flannel’, with ‘docker’ as the default. With the ‘docker’ driver, containers are connected to the ‘docker0’ bridge on each node and are assigned local IP address. With the ‘flannel’ driver, containers are connected to a flat overlay network and are assigned IP address by Flannel. Refer to the Networking section for more details.

**Volume driver (volume-driver)**

Specified in the ClusterTemplate to select the volume driver to provide persistent storage for containers. The supported volume driver is ‘rexray’. The default is no volume driver. When ‘rexray’ or other volume driver is deployed, you can use the Docker ‘volume’ command to create, mount, unmount, delete volumes in containers. Cinder block storage is used as the backend to support this feature. Refer to the Storage section for more details.

**Storage driver (docker-storage-driver)**

Specified in the ClusterTemplate to select the Docker storage driver. The default is ‘devicemapper’. Refer to the Storage section for more details.

**Image (image)**

Specified in the ClusterTemplate to indicate the image to boot the servers for the Swarm manager and node. The image binary is loaded in Glance with the attribute ‘os_distro = fedora-atomic’. Current supported image is Fedora Atomic (download from Fedora )

**TLS (tls-disabled)**

Transport Layer Security is enabled by default to secure the Swarm API for access by both the users and Magnum. You will need a key and a signed certificate to access the Swarm API and CLI. Magnum handles its own key and certificate when interfacing with the Swarm cluster. In development mode, TLS can be disabled. Refer to the ‘Transport Layer Security’_ section for details on how to create your key and have Magnum sign your certificate.

### Log into the servers
You can log into the manager and node servers with the account ‘fedora’ and the keypair specified in the ClusterTemplate.
In addition to the common attributes in the ClusterTemplate, you can specify the following attributes that are specific to Swarm by using the labels attribute.

**swarm_strategy**

This label corresponds to Swarm parameter for master ‘–strategy’. For more details, refer to the Swarm Strategy. Valid values for this label are:

* spread
* binpack
* random
