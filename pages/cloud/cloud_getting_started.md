---
title: Getting started with the Cloud Platform
keywords: Getting started with the Cloud Platform
last_updated: May 20, 2019
tags: [getting_started, cloud]
summary: "How to get started using the Cloud Platform to create your first virtual machine and network infrastructure"
sidebar: cloud_sidebar
permalink: cloud_getting_started.html
folder: cloud
---

We offer a public cloud based on OpenStack. This robust and powerful cloud platform is ideal for companies that need a high-performance Linux environment, are looking for extreme scalability, use their own images, or have a high level of network complexity.

OpenStack is a collection of open source cloud components (compute, networking and storage) for building and running a cloud platform for public, private and hybrid clouds. Supported by companies like HP, Cisco, Red Hat, and IBM.

OpenStack has an enormous momentum. These days, many cloud users want an open platform to build their future cloud infrastructure upon, without having to fear vendor lock-in with first-generation cloud providers like Amazon Web Services and Microsoft. Therefore, companies choose OpenStack

In this guide we'll walk through all the steps to get a new instance set up in a new empty project. At the end you will have a project with the required network components, security groups and SSH keys. This guide will use the Horizon Dashboard. See our [other guide] for the CLI version.

## Public or Private network


If you want a Virtual Server with just a public IP address (no private network), less steps are required.

You can skip the "Create Network" step.

## Creating security groups


Security groups are firewall rules for your instances.  You can use them to allow or limit certain traffic or ports.  The default security group doesn't allow any incoming traffic.

We must create our own security group to allow traffic.

* [Login to the Dashboard and select the relevant region][cloud_dashboard_login]

* In the "Project Tab" under "Network", click "Security Groups".

* Click "+ Create Security Group".

* Name it "allow-web-management".

* We will allow port 80, 443 and 22 in this example.

* Click "Manage Rules" for this new security group.

* Click "+ Add Rule"

* Add the following ingress rules:

  * ALL ICMP
  * HTTP
  * HTTPS
  * SSH or RDP

  If you want you can limit the rule to a specific IP or range by entering that in the CIDR field.

## Adding SSH key


SSH will be used to manage your Linux instances via the command line.

Our images have Cloud Init and will automatically place your SSH key in the instance so you can access the instance right away.

Windows instances will use the ssh key to encrypt the randomly generated Administrator password which can the be retreived.

If you don't know how to create an SSH key, read [this guide](https://help.github.com/en/articles/generating-a-new-ssh-key-and-adding-it-to-the-ssh-agent) for more information.

In the "Project Tab", click 'Compute' and make sure you're on the "Key Pairs" tab.

If you don't want to generate an SSH keypair yourself, you can click "+ Create Key Pair".
A key pair will be created and you will be able to download the private key part.
We don't save this and you cannot download the file again, so make sure you save it.

{% include warning.html content="We do not recommend the above. Please generate the SSH key yourself and make sure it has a password on the private part." %}

Click "Import Key Pair" and paste your public key. Give it a recognizable name.



## Create Network


If you want an instance with just a public IP, then you can skip the following steps until "Launch Instance". If you want a instance in a private network, you must first create a few resources.

A public IP is removed from the instance when it is deleted. You cannot recover it. If you use a Floating IP, that will stay in your account once you delete a instance. You can couple it to another instance if needed. For a Floating IP, a instance must be in a private network.

In the "Project Tab", click "Network" and make sure you're on the "Networks" tab.

* Click "+ Create Network".
  * Give it a name and make sure the "Admin State" checkbox is checked. Otherwise your network will be down.

* In the modal dialog window, click the "Subnet" button and give your subnet a "Name" and "Network Address".
  * The network address can be something like "192.168.1.0/24".
  * Leave the other fields blank or default.

* In the modal dialog window, click the "Subnet Details" button and enter DNS nameservers (8.8.8.8, 8.8.4.4 for example).
  * The other fields can be left blank.

* Click the "Create" button.

Your network will now be created.

## Create router


To allow your newly created network internet access you need a router.

The router works just as at home, all traffic from instances in the network will go through the router.

In the "Project Tab", click "Network" and make sure you're on the "Routers" tab.

* Click "+ Create Router" and give your router a name.

* In the overview list, under "Actions", click "Set Gateway".
  * Select the network "external" and click "Set Gateway".
  * This sets the router up for external networking.

* Click the newly created router and in the overview screen, click "+ Add Interface".
  * Select the subnet we just created and click "Add Interface".
  * This sets the router up for internal networking.

We're now ready to launch our first instance.

## Launch instance


In the "Project Tab", click "Compute" and make sure you're on the "Instances" tab.

* Click "+ Launch Instance".

* Give your instance a name and select the Availability Zone.
  * If you want more then one instance, you can enter that as well

* Select the "Source" tab.
  * Choose the image you want to boot the server from.
  * In the example we'll select "Windows Server 2016 Standard".
  * The "Boot Source" is image and "Create New Volume" is set to Yes.

* Select the "Flavor" tab.
  * Choose the flavor you want for the instance.
  * In the example we'll select "c5.small".

* Select the "Networks" tab.
  * If you want just a public IP, select 'external'.
  * If you created a private network, you can select that.
  * You can select multiple networks.

* Select the "Security Groups" tag.
  * Add the security group we created earlier.

* Select the "Key Pair" tab.
  * Select the keypair we created earlier.

* The other tabs are optional.

* Click "Launch Instance".

In the overview screen your instance will be listed, first with state "Spawning" and after a few seconds "Running".

If the instance has a public IP, you can login to it directly.

If the instance is in the private network, we need to add a floating IP.

## Add a floating IP

In the "Project Tab", click "Network" and make sure you're on the "Floating IPs" tab.

* Click "Allocate IP To Project"
  * select the "external" Pool and click "Allocate IP".

In the "Project Tab", click "Network" and make sure you're on the "Instances" tab.

* In the list, on the server you want to allocate the floating IP to, under "Actions", select the down arrow.
* Click "Associate Floating IP".
  * Select the floating IP and click "Associate".
* The floating IP will now be available for use to access the instance.

You can now SSH into the server and do anything you please.

## Retrieve admin password

Windows instances will automatically generate a password for the Administrator user during the initial boot.

This password can be retreived and decrypted using the Key pair that was used when creating the instance


Congratulations, your first Cloud Platform server is setup!

{% include links.html %}
