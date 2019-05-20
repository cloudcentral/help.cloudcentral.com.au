---
title: Launch and manage instances using the Dashboard
tags: [dashboard, instance]
keywords: dashboard, instance, launch
last_updated: April 11, 2018
summary: "How to launch and manage compute instances"
sidebar: cloud_sidebar
permalink: cloud_dashboard_instances.html
folder: cloud
---

Instances are virtual machines that run inside the cloud. You can launch an instance from the following sources:

* Images uploaded to the Image service.
* Image that you have copied to a persistent volume.
* Instance snapshot that you took.

## Launch an instance
1. [Log in to the dashboard](cloud_dashboard_login.html).

1. Select the appropriate project from the drop down menu at the top left.

1. On the Project tab, open the Compute tab and click Instances category.

   The dashboard shows the instances with its name, its private and floating IP addresses, size, status, task, power state, and so on.

1. Click Launch Instance.

1. In the Launch Instance dialog box, specify the following values:

   - Details tab

     - **Instance Name**

       Assign a name to the virtual machine.

       {% include note.html content="The name you assign here becomes the initial host name of the server. If the name is longer than 63 characters, the Compute service truncates it automatically to ensure dnsmasq works correctly.<br/><br/>After the server is built, if you change the server name in the API or change the host name directly, the names are not updated in the dashboard.<br/><br/>Server names are not guaranteed to be unique when created so you could have two instances with the same host name." %}

     - **Availability Zone**
       By default, this value is set to the availability zone given by the cloud provider (for example, us-west or apac-south). For some cases, it could be nova.

     - **Count**
       To launch multiple instances, enter a value greater than 1. The default is 1.

   - Source tab

     - **Select Boot Source**

       Your options are:

       - **Image**
         If you choose this option, a new field for Image Name displays. You can select the image from the list.

       - **Instance Snapshot**
         If you choose this option, a new field for Instance Snapshot displays. You can select the snapshot from the list.

       - **Volume**
         If you choose this option, a new field for Volume displays. You can select the volume from the list.

       - **Volume Snapshot**
         If you choose this option, a new field for Volume Snapshot displays. You can select the snapshot from the list.

     - **Create new volume**
       With this option enabled, you can create a volume by entering the Volume Size for your volume.

     - **Delete volume on instance delete**
       With this option enabled, you can delete the volume on deleting the instance.

   - Flavor tab

     - **Flavor**
       Specify the size of the instance to launch.

     {% include note.html content="The flavor is selected based on the size of the image selected for launching an instance. For example, while creating an image, if you have entered the value in the Minimum RAM (MB) field as 2048, then on selecting the image, the default flavor is m1.small." %}

   - Networks tab

     - **Selected Networks**
       To add a network to the instance, click the + in the Available field.

   - Network Ports tab

     - **Ports**
       Activate the ports that you want to assign to the instance.

   - Security Groups tab

     - **Security Groups**
       Activate the security groups that you want to assign to the instance.

       Security groups are a kind of cloud firewall that define which incoming network traffic is forwarded to instances.

       If you have not [created any security groups](cloud_dashboard_security.html#addrule), you can assign only the default security group to the instance.

   - Key Pair tab

     - **Key Pair**
       Specify a key pair.

       If the image uses a static root password or a static key set (neither is recommended), you do not need to provide a key pair to launch the instance.

   - Configuration tab

     - **Customization Script Source**
       Specify a customization script that runs after your instance launches.

   - Metadata tab

     - **Available Metadata**
       Add Metadata items to your instance.

1. Click Launch Instance.

The instance starts on a compute node in the cloud.

{% include note.html content="If you did not provide a key pair, security groups, or rules, users can access the instance only from inside the cloud through VNC. Even pinging the instance is not possible without an ICMP rule configured." %}

## Connect to your instance by using SSH
To use SSH to connect to your instance, use the downloaded keypair file.

{% include note.html content="The user name is ubuntu for the Ubuntu cloud images on TryStack." %}

Copy the IP address for your instance.

Use the ssh command to make a secure connection to the instance. For example:

```sh
$ ssh -i MyKey.pem ubuntu@10.0.0.2
```
At the prompt, type yes.

It is also possible to SSH into an instance without an SSH keypair, if the administrator has enabled root password injection. For more information about root password injection, see Injecting the administrator password in the OpenStack Administrator Guide.

## Track usage for instances
You can track usage for instances for each project. You can track costs per month by showing meters like number of vCPUs, disks, RAM, and uptime for all your instances.

1. [Log in to the dashboard](cloud_dashboard_login.html).
1. Select the appropriate project from the drop down menu at the top left.
1. On the Project tab, open the Compute tab and click Overview category.
1. To query the instance usage for a month, select a month and click Submit.
1. To download a summary, click Download CSV Summary.

## Create an instance snapshot
1. [Log in to the dashboard](cloud_dashboard_login.html).

1. Select the appropriate project from the drop down menu at the top left.

1. On the Project tab, open the Compute tab and click the Instances category.

1. Select the instance from which to create a snapshot.

1. In the actions column, click Create Snapshot.

1. In the Create Snapshot dialog box, enter a name for the snapshot, and click Create Snapshot.

   The Images category shows the instance snapshot.

To launch an instance from the snapshot, select the snapshot and click Launch. Proceed with launching an instance.

## Manage an instance
1. [Log in to the dashboard](cloud_dashboard_login.html).

1. Select the appropriate project from the drop down menu at the top left.

1. On the Project tab, open the Compute tab and click Instances category.

1. Select an instance.

1. In the menu list in the actions column, select the state.

   You can resize or rebuild an instance. You can also choose to view the instance console log, edit instance or the security groups. Depending on the current state of the instance, you can pause, resume, suspend, soft or hard reboot, or terminate it.

{% include links.html %}
