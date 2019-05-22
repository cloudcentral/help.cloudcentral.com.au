---
title: Manage IP addresses using the CLI
tags: [cli, instance, ipaddress]
keywords: cli, instance, ipaddress
last_updated: May 20, 2019
summary: "How to manage instance IP addresses using the CLI"
sidebar: cloud_sidebar
permalink: cloud_cli_instance_ip.html
folder: cloud
---

Each instance has a private, fixed IP address and can also have a public, or floating IP address. Private IP addresses are used for communication between instances, and public addresses are used for communication with networks outside the cloud, including the Internet.

When you launch an instance, it is automatically assigned a private IP address that stays the same until you explicitly terminate the instance. Rebooting an instance has no effect on the private IP address.

A pool of floating IP addresses, configured by the cloud administrator, is available in OpenStack Compute. The project quota defines the maximum number of floating IP addresses that you can allocate to the project. After you allocate a floating IP address to a project, you can:

* Associate the floating IP address with an instance of the project. Only one floating IP address can be allocated to an instance at any given time.
* Disassociate a floating IP address from an instance in the project.
* Delete a floating IP from the project which automatically deletes that IP’s associations.
Use the nova floating-ip-\* commands to manage floating IP addresses.

## List floating IP address information {#list_floating_ip}

To list all floating IP addresses that are allocated to the current project, run:
```sh
$ openstack floating ip list
+--------------+--------------------------------------+----------+--------+
| Ip           | Instance Id                          | Fixed Ip | Pool   |
+--------------+--------------------------------------+----------+--------+
| 172.24.4.225 | 4a60ff6a-7a3c-49d7-9515-86ae501044c6 | 10.0.0.2 | public |
| 172.24.4.226 | None                                 | None     | public |
+--------------+--------------------------------------+----------+--------+
```
For each floating IP address that is allocated to the current project, the command outputs the floating IP address, the ID for the instance to which the floating IP address is assigned, the associated fixed IP address, and the pool from which the floating IP address was allocated.

## Associate floating IP addresses {#associate_floating_ip}
You can assign a floating IP address to a project and to an instance.

1. Run the following command to allocate a floating IP address to the current project. The command outputs the allocated IP address:
   ```sh
   $ openstack floating ip create external
   +--------------+-------------+----------+--------+
   | IP           | Instance Id | Fixed IP | Pool   |
   +--------------+-------------+----------+--------+
   | 172.24.4.225 | None        | None     | public |
   +--------------+-------------+----------+--------+
   ```
   {{site.data.alerts.note}}
   <p>If more than one IP address pool is available, you can specify from which pool to allocate the IP address, using the pool’s name. For example, to allocate a floating IP address from the test pool, run:</p>
   <pre>$ nova floating-ip-create test<br/></pre>
   {{site.data.alerts.end}}

1. List all project instances with which a floating IP address could be associated.
   ```sh
   $ openstack server list
   +---------------------+------+---------+------------+-------------+------------------+
   | ID                  | Name | Status  | Task State | Power State | Networks         |
   +---------------------+------+---------+------------+-------------+------------------+
   | d5c854f9-d3e5-4f... | VM1  | ACTIVE  | -          | Running     | private=10.0.0.3 |
   | 42290b01-0968-43... | VM2  | SHUTOFF | -          | Shutdown    | private=10.0.0.4 |
   +---------------------+------+---------+------------+-------------+------------------+
   ```
1. Associate an IP address with an instance in the project, as follows:
   ```sh
   $ openstack server add floating ip INSTANCE_NAME_OR_ID FLOATING_IP_ADDRESS
   ```
   For example:
   ```sh
   $ openstack server add floating ip VM1 172.24.4.225
   ```
   The instance is now associated with two IP addresses:
   ```sh
   $ openstack server list
   +------------------+------+--------+------------+-------------+-------------------------------+
   | ID               | Name | Status | Task State | Power State | Networks                      |
   +------------------+------+--------+------------+-------------+-------------------------------+
   | d5c854f9-d3e5... | VM1  | ACTIVE | -          | Running     | private=10.0.0.3, 172.24.4.225|
   | 42290b01-0968... | VM2  | SHUTOFF| -          | Shutdown    | private=10.0.0.4              |
   +------------------+------+--------+------------+-------------+-------------------------------+
   ```
   After you associate the IP address and configure security group rules for the instance, the instance is publicly available at the floating IP address.

   {{site.data.alerts.note}}
   <p>If an instance is connected to multiple networks, you can associate a floating IP address with a specific fixed IP address using the optional --fixed-address parameter:</p>
   <pre>$ openstack server add floating ip --fixed-address FIXED_IP_ADDRESS \  INSTANCE_NAME_OR_ID FLOATING_IP_ADDRESS</pre>
   {{site.data.alerts.end}}

## Disassociate floating IP addresses {#associate_floating_ip}
To disassociate a floating IP address from an instance:
```sh
$ openstack server remove floating ip INSTANCE_NAME_OR_ID FLOATING_IP_ADDRESS
```
To remove the floating IP address from a project:
```sh
$ openstack floating ip delete FLOATING_IP_ADDRESS
```
The IP address is returned to the pool of IP addresses that is available for all projects. If the IP address is still associated with a running instance, it is automatically disassociated from that instance.


