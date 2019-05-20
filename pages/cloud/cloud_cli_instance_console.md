---
title: Access and instanes console using the CLI
tags: [cli, instance, console]
keywords: cli, instance, console
last_updated: April 11, 2018
summary: "How to access the console of an instance using the CLI"
sidebar: cloud_sidebar
permalink: cloud_cli_instance_console.html
folder: cloud
---

VNC or SPICE is used to view the console output of an instance, regardless of whether or not the console log has output. This allows relaying keyboard and mouse activity to and from an instance.

There are three remote console access methods commonly used with OpenStack:

**novnc**
  - An in-browser VNC client implemented using HTML5 Canvas and WebSockets

**spice**
  - A complete in-browser client solution for interaction with virtualized instances

**xvpvnc**
  - A Java client offering console access to an instance

Example:

To access an instance through a remote console, run the following command:
```
$ openstack console url show INSTANCE_NAME --xvpvnc
```
The command returns a URL from which you can access your instance:
```
+--------+------------------------------------------------------------------------------+
| Type   | Url                                                                          |
+--------+------------------------------------------------------------------------------+
| xvpvnc | http://192.168.5.96:6081/console?token=c83ae3a3-15c4-4890-8d45-aefb494a8d6c  |
+--------+------------------------------------------------------------------------------+
```
--xvpvnc can be replaced by any of the above values as connection types.

When using SPICE to view the console of an instance, a browser plugin can be used directly on the instance page, or the openstack console url show command can be used with it, as well, by returning a token-authenticated address, as in the example above.

For further information and comparisons (including security considerations), see the Security Guide.
