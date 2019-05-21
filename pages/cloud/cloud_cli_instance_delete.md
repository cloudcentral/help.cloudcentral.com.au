---
title: Delete an instance using the CLI
tags: [cli, instance, delete]
keywords: cli, instance, delete
last_updated: May 20, 2019
summary: "How to delete an instance using the CLI"
sidebar: cloud_sidebar
permalink: cloud_cli_instance_delete.html
folder: cloud
---

When you no longer need an instance, you can delete it.

1. List all instances:
   ```sh
   $ nova list
   +-------------+----------------------+--------+------------+-------------+------------------+
   | ID          | Name                 | Status | Task State | Power State | Networks         |
   +-------------+----------------------+--------+------------+-------------+------------------+
   | 84c6e57d... | myCirrosServer       | ACTIVE | None       | Running     | private=10.0.0.3 |
   | 8a99547e... | myInstanceFromVolume | ACTIVE | None       | Running     | private=10.0.0.4 |
   | d7efd3e4... | newServer            | ERROR  | None       | NOSTATE     |                  |
   +-------------+----------------------+--------+------------+-------------+------------------+
   ```
1. Run the nova delete command to delete the instance. The following example shows deletion of the newServer instance, which is in ERROR state:
   ```sh
   $ nova delete newServer
   ```
   The command does not notify that your server was deleted.

1. To verify that the server was deleted, run the nova list command:
   ```sh
   $ nova list
   +-------------+----------------------+--------+------------+-------------+------------------+
   | ID          | Name                 | Status | Task State | Power State | Networks         |
   +-------------+----------------------+--------+------------+-------------+------------------+
   | 84c6e57d... | myCirrosServer       | ACTIVE | None       | Running     | private=10.0.0.3 |
   | 8a99547e... | myInstanceFromVolume | ACTIVE | None       | Running     | private=10.0.0.4 |
   +-------------+----------------------+--------+------------+-------------+------------------+
   ```
   The deleted instance does not appear in the list.



