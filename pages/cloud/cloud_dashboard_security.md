---
title: Configure access and security for instances
tags: [dashboard, security, instance]
keywords: dashboard, instance, security
last_updated: April 11, 2018
summary: "How to manage security groups and key pairs"
sidebar: cloud_sidebar
permalink: cloud_dashboard_security.html
folder: cloud
---

Before you launch an instance, you should add security group rules to enable users to ping and use SSH to connect to the instance. Security groups are sets of IP filter rules that define networking access and are applied to all instances within a project. To do so, you either [add a rule to the default security group](#addrule) or add a new security group with rules.

Key pairs are SSH credentials that are injected into an instance when it is launched. To use key pair injection, the image that the instance is based on must contain the cloud-init package. Each project should have at least one key pair. For more information, see the section Add a key pair.

If you have generated a key pair with an external tool, you can import it into OpenStack. The key pair can be used for multiple instances that belong to a project. For more information, see the section Import a key pair.

{% include note.html content="A key pair belongs to an individual user, not to a project. To share a key pair across multiple users, each user needs to import that key pair." %}

When an instance is created in OpenStack, it is automatically assigned a fixed IP address in the network to which the instance is assigned. This IP address is permanently associated with the instance until the instance is terminated. However, in addition to the fixed IP address, a floating IP address can also be attached to an instance. Unlike fixed IP addresses, floating IP addresses are able to have their associations modified at any time, regardless of the state of the instances involved.

## Add a rule to the default security group {#addrule}
This procedure enables SSH and ICMP (ping) access to instances. The rules apply to all instances within a given project, and should be set for every project unless there is a reason to prohibit SSH or ICMP access to the instances.

This procedure can be adjusted as necessary to add additional security group rules to a project, if your cloud requires them.

{% include note.html content="When adding a rule, you must specify the protocol used with the destination port or source port." %}

1. [Log in to the dashboard](cloud_dashboard_login.html).

1. Select the appropriate project from the drop down menu at the top left.

1. On the Project tab, open the Compute tab and click Access & Security category. The Security Groups tab shows the security groups that are available for this project.

1. Select the default security group and click Manage Rules.

1. To allow SSH access, click Add Rule.

1. In the Add Rule dialog box, enter the following values:

   * **Rule**: SSH * **Remote**: CIDR
   * **CIDR**: 0.0.0.0/0

   {% include note.html content="To accept requests from a particular range of
   IP addresses, specify the IP address block in the CIDR box." %}

1. Click Add.

   Instances will now have SSH port 22 open for requests from any IP address.

1. To add an ICMP rule, click Add Rule.

1. In the Add Rule dialog box, enter the following values:

   * **Rule**: All ICMP
   * **Direction**: Ingress
   * **Remote**: CIDR
   * **CIDR**: 0.0.0.0/0
1. Click Add.

   Instances will now accept all incoming ICMP packets.

## Add a key pair
Create at least one key pair for each project.

1. [Log in to the dashboard](cloud_dashboard_login.html).
1. Select the appropriate project from the drop down menu at the top left.
1. On the Project tab, open the Compute tab and click Access & Security category.
1. Click the Key Pairs tab, which shows the key pairs that are available for this project.
1. Click Create Key Pair.
1. In the Create Key Pair dialog box, enter a name for your key pair, and click Create Key Pair.
1. Respond to the prompt to download the key pair.

## Import a key pair
1. [Log in to the dashboard](cloud_dashboard_login.html).

1. Select the appropriate project from the drop down menu at the top left.

1. On the Project tab, open the Compute tab and click Access & Security category.

1. Click the Key Pairs tab, which shows the key pairs that are available for this project.

1. Click Import Key Pair.

1. In the Import Key Pair dialog box, enter the name of your key pair, copy the public key into the Public Key box, and then click Import Key Pair.

1. Save the \*.pem file locally.

1. To change its permissions so that only you can read and write to the file, run the following command:

   ```sh
   $ chmod 0600 yourPrivateKey.pem
   ```

   {% include note.html content="If you are using the Dashboard from a Windows computer, use PuTTYgen to load the *.pem file and convert and save it as *.ppk. For more information see the WinSCP web page for PuTTYgen." %}

1. To make the key pair known to SSH, run the ssh-add command.

   ```sh
   $ ssh-add yourPrivateKey.pem
   ```

The Compute database registers the public key of the key pair.

The Dashboard lists the key pair on the Access & Security tab.

## Allocate a floating IP address to an instance
When an instance is created in OpenStack, it is automatically assigned a fixed IP address in the network to which the instance is assigned. This IP address is permanently associated with the instance until the instance is terminated.

However, in addition to the fixed IP address, a floating IP address can also be attached to an instance. Unlike fixed IP addresses, floating IP addresses can have their associations modified at any time, regardless of the state of the instances involved. This procedure details the reservation of a floating IP address from an existing pool of addresses and the association of that address with a specific instance.

1. [Log in to the dashboard](cloud_dashboard_login.html).

1. Select the appropriate project from the drop down menu at the top left.

1. On the Project tab, open the Compute tab and click Access & Security category.

1. Click the Floating IPs tab, which shows the floating IP addresses allocated to instances.

1. Click Allocate IP To Project.

1. Choose the pool from which to pick the IP address.

1. Click Allocate IP.

1. In the Floating IPs list, click Associate.

1. In the Manage Floating IP Associations dialog box, choose the following options:

   * The IP Address field is filled automatically, but you can add a new IP address by clicking the + button.

   * In the Port to be associated field, select a port from the list.

   * The list shows all the instances with their fixed IP addresses.

1. Click Associate.

{% include note.html content="To disassociate an IP address from an instance, click the Disassociate button." %}

To release the floating IP address back into the floating IP pool, click the Release Floating IP option in the Actions column.
