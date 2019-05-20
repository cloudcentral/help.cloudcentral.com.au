---
title: Manage the environment using the CLI
tags: [cli,cloud, getting_started]
keywords: cli
last_updated: April 11, 2018
summary: "How to use the CLI"
sidebar: cloud_sidebar
permalink: cloud_cli_overview.html
folder: cloud
---

OpenStackClient project provides a unified command-line client, which enables you to access the project API through easy-to-use commands. Also, most OpenStack project provides a command-line client for each service. For example, the Compute service provides a nova command-line client.

You can run the commands from the command line, or include the commands within scripts to automate tasks. If you provide OpenStack credentials, such as your user name and password, you can run these commands on any computer.

Internally, each command uses cURL command-line tools, which embed API requests. OpenStack APIs are RESTful APIs, and use the HTTP protocol. They include methods, URIs, media types, and response codes.

OpenStack APIs are open-source Python clients, and can run on Linux or Mac OS X systems. On some client commands, you can specify a debug parameter to show the underlying API request for the command. This is a good way to become familiar with the OpenStack API calls.

As a cloud end user, you can use the OpenStack dashboard to provision your own resources within the limits set by administrators. You can modify the examples provided in this section to create other types and sizes of server instances.

## Unified command-line client
You can use the unified openstack command (python-openstackclient) for the most of OpenStack services. For more information, see [OpenStackClient document](http://docs.openstack.org/developer/python-openstackclient/).
