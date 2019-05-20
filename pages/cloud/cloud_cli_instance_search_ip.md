---
title: Search for an instance using IP address
tags: [cli, instance, search, ipaddress]
keywords: cli, instance, search, ipaddress, networks
last_updated: April 11, 2018
summary: "How to search for an instance by IP using the CLI"
sidebar: cloud_sidebar
permalink: cloud_cli_instance_search_ip.html
folder: cloud
---

You can search for an instance using the IP address parameter, --ip, with the nova list command.
```sh
$ nova list --ip IP_ADDRESS
```
The following example shows the results of a search on 10.0.0.4.
```sh
$ nova list --ip 10.0.0.4
+------------------+----------------------+--------+------------+-------------+------------------+
| ID               | Name                 | Status | Task State | Power State | Networks         |
+------------------+----------------------+--------+------------+-------------+------------------+
| 8a99547e-7385... | myInstanceFromVolume | ACTIVE | None       | Running     | private=10.0.0.4 |
+------------------+----------------------+--------+------------+-------------+------------------+
```
