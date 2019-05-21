---
title: Manage instances and hosts using the CLI
tags: [cli, instance, volume, network, ipaddress]
keywords: cli, instance, volume, network, ipaddress
last_updated: May 20, 2019
summary: "How to manage instances using the CLI"
sidebar: cloud_sidebar
permalink: cloud_cli_instances_hosts.html
folder: cloud
---

Instances are virtual machines that run inside the cloud on physical compute nodes. The Compute service manages instances. A host is the node on which a group of instances resides.

This section describes how to perform the different tasks involved in instance management, such as adding floating IP addresses, stopping and starting instances, and terminating instances. This section also discusses node management tasks.

* [Manage IP addresses][cloud_cli_instance_ip]
  - [List floating IP address information][cloud_cli_instance_ip.html#list_floating_ip]
  - [Associate floating IP addresses][cloud_cli_instance_ip.html#associate_floating_ip]
  - [Disassociate floating IP addresses][cloud_cli_instance_ip.html#disassociate_floating_ip]
* [Change the size of your server][cloud_cli_instance_resize]
* [Stop and start an instance][cloud_cli_instance_restart]
  - [Pause and unpause an instance][cloud_cli_instance_restart.html#pausing]
  - [Suspend and resume an instance][cloud_cli_instance_restart.html#suspending]
  - [Shelve and unshelve an instance][cloud_cli_instance_restart.html#shelving]
* [Search for an instance using IP address][cloud_cli_instance_search_ip]
* [Reboot an instance][cloud_cli_instance_reboot]
* [Delete an instance][cloud_cli_instance_delete]
* [Access an instance through a console][cloud_cli_instance_console]

{% include links.html %}
