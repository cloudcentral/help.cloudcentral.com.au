---
title: Create and manage networks using the CLI
tags: [cli, network]
keywords: cli, networks
last_updated: May 20, 2019
summary: "How to create and manage networks using the CLI"
sidebar: cloud_sidebar
permalink: cloud_cli_networks.html
folder: cloud
---

Before you run commands, set environment variables using the [OpenStack RC file.][cloud_cli_config]

## Create networks
1. List the extensions of the system:
   ```sh
   $ neutron ext-list -c alias -c name
   +-----------------+--------------------------+
   | alias           | name                     |
   +-----------------+--------------------------+
   | agent_scheduler | Agent Schedulers         |
   | binding         | Port Binding             |
   | quotas          | Quota management support |
   | agent           | agent                    |
   | provider        | Provider Network         |
   | router          | Neutron L3 Router        |
   | lbaas           | LoadBalancing service    |
   | extraroute      | Neutron Extra Route      |
   +-----------------+--------------------------+
   ```
1. Create a network:
   ```sh
   $ neutron net-create net1
   Created a new network:
   +---------------------------+--------------------------------------+
   | Field                     | Value                                |
   +---------------------------+--------------------------------------+
   | admin_state_up            | True                                 |
   | id                        | 2d627131-c841-4e3a-ace6-f2dd75773b6d |
   | name                      | net1                                 |
   | provider:network_type     | vlan                                 |
   | provider:physical_network | physnet1                             |
   | provider:segmentation_id  | 1001                                 |
   | router:external           | False                                |
   | shared                    | False                                |
   | status                    | ACTIVE                               |
   | subnets                   |                                      |
   | tenant_id                 | 3671f46ec35e4bbca6ef92ab7975e463     |
   +---------------------------+--------------------------------------+
   ```

   {% include note.html content="Some fields of the created network are invisible to non-admin users." %}

1. Create a network with specified provider network type.
   ```sh
   $ neutron net-create net2 --provider:network-type local
   Created a new network:
   +---------------------------+--------------------------------------+
   | Field                     | Value                                |
   +---------------------------+--------------------------------------+
   | admin_state_up            | True                                 |
   | id                        | 524e26ea-fad4-4bb0-b504-1ad0dc770e7a |
   | name                      | net2                                 |
   | provider:network_type     | local                                |
   | provider:physical_network |                                      |
   | provider:segmentation_id  |                                      |
   | router:external           | False                                |
   | shared                    | False                                |
   | status                    | ACTIVE                               |
   | subnets                   |                                      |
   | tenant_id                 | 3671f46ec35e4bbca6ef92ab7975e463     |
   +---------------------------+--------------------------------------+
   ```
   Just as shown previously, the unknown option --provider:network-type is used to create a local provider network.

## Create subnets
Create a subnet:
```sh
$ neutron subnet-create net1 192.168.2.0/24 --name subnet1
Created a new subnet:
+------------------+--------------------------------------------------+
| Field            | Value                                            |
+------------------+--------------------------------------------------+
| allocation_pools | {"start": "192.168.2.2", "end": "192.168.2.254"} |
| cidr             | 192.168.2.0/24                                   |
| dns_nameservers  |                                                  |
| enable_dhcp      | True                                             |
| gateway_ip       | 192.168.2.1                                      |
| host_routes      |                                                  |
| id               | 15a09f6c-87a5-4d14-b2cf-03d97cd4b456             |
| ip_version       | 4                                                |
| name             | subnet1                                          |
| network_id       | 2d627131-c841-4e3a-ace6-f2dd75773b6d             |
| tenant_id        | 3671f46ec35e4bbca6ef92ab7975e463                 |
+------------------+--------------------------------------------------+
```
The subnet-create command has the following positional and optional parameters:

- The name or ID of the network to which the subnet belongs.

  In this example, net1 is a positional argument that specifies the network name.

- The CIDR of the subnet.

  In this example, 192.168.2.0/24 is a positional argument that specifies the CIDR.

- The subnet name, which is optional.

  In this example, --name subnet1 specifies the name of the subnet.

For information and examples on more advanced use of neutron’s subnet subcommand, see the OpenStack Administrator Guide.

## Create routers
1. Create a router:
   ```sh
   $ neutron router-create router1
   Created a new router:
   +-----------------------+--------------------------------------+
   | Field                 | Value                                |
   +-----------------------+--------------------------------------+
   | admin_state_up        | True                                 |
   | external_gateway_info |                                      |
   | id                    | 6e1f11ed-014b-4c16-8664-f4f615a3137a |
   | name                  | router1                              |
   | status                | ACTIVE                               |
   | tenant_id             | 7b5970fbe7724bf9b74c245e66b92abf     |
   +-----------------------+--------------------------------------+
   ```
   Take note of the unique router identifier returned, this will be required in subsequent steps.

1. Link the router to the external provider network:
   ```sh
   $ neutron router-gateway-set ROUTER NETWORK
   ```
   Replace ROUTER with the unique identifier of the router, replace NETWORK with the unique identifier of the external provider network.

1. Link the router to the subnet:
   ```sh
   $ neutron router-interface-add ROUTER SUBNET
   ```
   Replace ROUTER with the unique identifier of the router, replace SUBNET with the unique identifier of the subnet.

## Create ports
1. Create a port with specified IP address:
   ```sh
   $ neutron port-create net1 --fixed-ip ip_address=192.168.2.40
   Created a new port:
   +----------------------+----------------------------------------------------------------------+
   | Field                | Value                                                                |
   +----------------------+----------------------------------------------------------------------+
   | admin_state_up       | True                                                                 |
   | binding:capabilities | {"port_filter": false}                                               |
   | binding:vif_type     | ovs                                                                  |
   | device_id            |                                                                      |
   | device_owner         |                                                                      |
   | fixed_ips            | {"subnet_id": "15a09f6c-87a5-4d14-b2cf-03d97cd4b456", "ip_address... |
   | id                   | f7a08fe4-e79e-4b67-bbb8-a5002455a493                                 |
   | mac_address          | fa:16:3e:97:e0:fc                                                    |
   | name                 |                                                                      |
   | network_id           | 2d627131-c841-4e3a-ace6-f2dd75773b6d                                 |
   | status               | DOWN                                                                 |
   | tenant_id            | 3671f46ec35e4bbca6ef92ab7975e463                                     |
   +----------------------+----------------------------------------------------------------------+
   ```
   In the previous command, net1 is the network name, which is a positional argument. --fixed-ip ip_address=192.168.2.40 is an option which specifies the port’s fixed IP address we wanted.

   {% include note.html content="When creating a port, you can specify any unallocated IP in the subnet even if the address is not in a pre-defined pool of allocated IP addresses (set by your cloud provider)." %}

1. Create a port without specified IP address:
   ```sh
   $ neutron port-create net1
   Created a new port:
   +----------------------+----------------------------------------------------------------------+
   | Field                | Value                                                                |
   +----------------------+----------------------------------------------------------------------+
   | admin_state_up       | True                                                                 |
   | binding:capabilities | {"port_filter": false}                                               |
   | binding:vif_type     | ovs                                                                  |
   | device_id            |                                                                      |
   | device_owner         |                                                                      |
   | fixed_ips            | {"subnet_id": "15a09f6c-87a5-4d14-b2cf-03d97cd4b456", "ip_address... |
   | id                   | baf13412-2641-4183-9533-de8f5b91444c                                 |
   | mac_address          | fa:16:3e:f6:ec:c7                                                    |
   | name                 |                                                                      |
   | network_id           | 2d627131-c841-4e3a-ace6-f2dd75773b6d                                 |
   | status               | DOWN                                                                 |
   | tenant_id            | 3671f46ec35e4bbca6ef92ab7975e463                                     |
   +----------------------+----------------------------------------------------------------------+
   ```
   {% include note.html content="Note that the system allocates one IP address if you do not specify an IP address in the neutron port-create command." %}

   {% include note.html content="You can specify a MAC address with --mac-address MAC_ADDRESS. If you specify an invalid MAC address, including 00:00:00:00:00:00 or ff:ff:ff:ff:ff:ff, you will get an error." %}

1. Query ports with specified fixed IP addresses:
   ```sh
   $ neutron port-list --fixed-ips ip_address=192.168.2.2 \
     ip_address=192.168.2.40
   +----------------+------+-------------------+-------------------------------------------------+
   | id             | name | mac_address       | fixed_ips                                       |
   +----------------+------+-------------------+-------------------------------------------------+
   | baf13412-26... |      | fa:16:3e:f6:ec:c7 | {"subnet_id"... ..."ip_address": "192.168.2.2"} |
   | f7a08fe4-e7... |      | fa:16:3e:97:e0:fc | {"subnet_id"... ..."ip_address": "192.168.2.40"}|
   +----------------+------+-------------------+-------------------------------------------------+
   --fixed-ips ip_address=192.168.2.2 ip_address=192.168.2.40 is one unknown option.
   ```

{% include links.html %}
