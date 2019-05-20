---
title: Configure access and security for instances using the CLI
tags: [cli, image]
keywords: cli, image
last_updated: April 11, 2018
summary: "How to configure access and security for instances using the CLI"
sidebar: cloud_sidebar
permalink: cloud_cli_security.html
folder: cloud
---

When you launch a virtual machine, you can inject a key pair, which provides SSH access to your instance. For this to work, the image must contain the cloud-init package.

You can create at least one key pair for each project. You can use the key pair for multiple instances that belong to that project. If you generate a key pair with an external tool, you can import it into OpenStack.

{% include note.html content="A key pair belongs to an individual user, not to a project. To share a key pair across multiple users, each user needs to import that key pair." %}

If an image uses a static root password or a static key set (neither is recommended), you must not provide a key pair when you launch the instance.

A security group is a named collection of network access rules that are use to limit the types of traffic that have access to instances. When you launch an instance, you can assign one or more security groups to it. If you do not create security groups, new instances are automatically assigned to the default security group, unless you explicitly specify a different security group.

The associated rules in each security group control the traffic to instances in the group. Any incoming traffic that is not matched by a rule is denied access by default. You can add rules to or remove rules from a security group, and you can modify rules for the default and any other security group.

You can modify the rules in a security group to allow access to instances through different ports and protocols. For example, you can modify rules to allow access to instances through SSH, to ping instances, or to allow UDP traffic; for example, for a DNS server running on an instance. You specify the following parameters for rules:

* Source of traffic. Enable traffic to instances from either IP addresses inside the cloud from other group members or from all IP addresses.
* Protocol. Choose TCP for SSH, ICMP for pings, or UDP.
* Destination port on virtual machine. Define a port range. To open a single port only, enter the same value twice. ICMP does not support ports; instead, you enter values to define the codes and types of ICMP traffic to be allowed.
Rules are automatically enforced as soon as you create or modify them.

{% include note.html content="Instances that use the default security group cannot, by default, be accessed from any IP address outside of the cloud. If you want those IP addresses to access the instances, you must modify the rules for the default security group." %}

You can also assign a floating IP address to a running instance to make it accessible from outside the cloud. See [Manage IP addresses](cloud_cli_instance_ip.html).

## Add a key pair
You can generate a key pair or upload an existing public key.

1. To generate a key pair, run the following command.
   ```shell
   $ openstack keypair create KEY_NAME > MY_KEY.pem
   ```
   This command generates a key pair with the name that you specify for KEY_NAME, writes the private key to the .pem file that you specify, and registers the public key to the Nova database.

1. To set the permissions of the .pem file so that only you can read and write to it, run the following command.
   ```shell
   $ chmod 600 MY_KEY.pem
   ```

## Import a key pair
1. If you have already generated a key pair and the public key is located at ~/.ssh/id_rsa.pub, run the following command to upload the public key.

   ```shell
   $ openstack keypair create --public-key ~/.ssh/id_rsa.pub KEY_NAME
   ```
   This command registers the public key at the Nova database and names the key pair the name that you specify for KEY_NAME.

1. To ensure that the key pair has been successfully imported, list key pairs as follows:

   ```shell
   $ openstack keypair list
   ```

## Create and manage security groups
1. To list the security groups for the current project, including descriptions, enter the following command:

   ```shell
   $ openstack security group list
   ```

1. To create a security group with a specified name and description, enter the following command:

   ```shell
   $ openstack security group create SECURITY_GROUP_NAME --description GROUP_DESCRIPTION
   ```
1. To delete a specified group, enter the following command:

   ```shell
   $ openstack security group delete SECURITY_GROUP_NAME
   ```

{% include note.html content="You cannot delete the default security group for a project. Also, you cannot delete a security group that is assigned to a running instance." %}

## Create and manage security group rules
Modify security group rules with the nova secgroup-\*-rule commands. Before you begin, source the OpenStack RC file. For details, see Set environment variables using the OpenStack RC file.

1. To list the rules for a security group, run the following command:

   ```shell
   $ openstack security group rule list SECURITY_GROUP_NAME
   ```
1. To allow SSH access to the instances, choose one of the following options:

   - Allow access from all IP addresses, specified as IP subnet 0.0.0.0/0 in CIDR notation:

     ```shell
     $ nova secgroup-add-rule SECURITY_GROUP_NAME tcp 22 22 0.0.0.0/0
     ```
   - Allow access only from IP addresses from other security groups (source groups) to access the specified port:

     ```shell
     $ nova secgroup-add-group-rule --ip_proto tcp --from_port 22 \
           --to_port 22 SECURITY_GROUP_NAME SOURCE_GROUP_NAME
     ```

1. To allow pinging of the instances, choose one of the following options:

   - Allow pinging from all IP addresses, specified as IP subnet 0.0.0.0/0 in CIDR notation.

     ```shell
     $ nova secgroup-add-rule SECURITY_GROUP_NAME icmp -1 -1 0.0.0.0/0
     ```

     This allows access to all codes and all types of ICMP traffic.

   - Allow only members of other security groups (source groups) to ping instances.
     ```shell
     $ nova secgroup-add-group-rule --ip_proto icmp --from_port -1 \
          --to_port -1 SECURITY_GROUP_NAME SOURCE_GROUP_NAME
     ```
1. To allow access through a UDP port, such as allowing access to a DNS server that runs on a VM, choose one of the following options:

   - Allow UDP access from IP addresses, specified as IP subnet 0.0.0.0/0 in CIDR notation.
     ```shell
     $ nova secgroup-add-rule SECURITY_GROUP_NAME udp 53 53 0.0.0.0/0
     ```
   - Allow only IP addresses from other security groups (source groups) to access the specified port.

     ```shell
     $ nova secgroup-add-group-rule --ip_proto udp --from_port 53 \
           --to_port 53 SECURITY_GROUP_NAME SOURCE_GROUP_NAME
     ```

## Delete a security group rule
To delete a security group rule, specify the same arguments that you used to create the rule.

For example, to delete the security group rule that permits SSH access from all IP addresses, run the following command.
```shell
$ nova secgroup-delete-rule SECURITY_GROUP_NAME tcp 22 22 0.0.0.0/0
```
