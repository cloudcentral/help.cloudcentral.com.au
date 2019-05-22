---
title: Manage Object containers using the CLI
tags: [cli, object, storage]
keywords: cli, object containers, storage
last_updated: May 20, 2019
summary: "How to manage Object containers using the CLI"
sidebar: cloud_sidebar
permalink: cloud_cli_object_containers.html
folder: cloud
---

To create a container, run the following command and replace CONTAINER with the name of your container.
```sh
$ openstack container create CONTAINER
```

To list all containers, run the following command:
```sh
$ openstack container list
```

To check the status of containers, run the following command:
```sh
$ openstack object store account show
+------------+---------------------------------------+
| Field      | Value                                 |
+------------+---------------------------------------+
| Account    | AUTH_1c80d7de201844c4bf5d2248bae23e4f |
| Bytes      | 0                                     |
| Containers | 1                                     |
| Objects    | 0                                     |
+------------+---------------------------------------+

$ openstack container show CONTAINER
+--------------+---------------------------------------+
| Field        | Value                                 |
+--------------+---------------------------------------+
| account      | AUTH_1c80d7de201844c4bf5d2248bae23e4f |
| bytes_used   | 0                                     |
| container    | CONTAINER                             |
| object_count | 0                                     |
+--------------+---------------------------------------+
```
