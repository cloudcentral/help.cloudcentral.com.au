---
title: Provide user data to instances using the CLI
tags: [cli, userdata]
keywords: cli, userdata
last_updated: May 20, 2019
summary: "How to provide userdata to an instance"
sidebar: cloud_sidebar
permalink: cloud_cli_userdata.html
folder: cloud
---

A user data file is a special key in the metadata service that holds a file that cloud-aware applications in the guest instance can access. For example, one application that uses user data is the cloud-init system, which is an open-source package from Ubuntu that is available on various Linux distributions and which handles early initialization of a cloud instance.

You can place user data in a local file and pass it through the --user-data ```user-data-file``` parameter at instance creation.

```sh
$ nova boot --image ubuntu-cloudimage --flavor 1 --user-data mydata.file
```
