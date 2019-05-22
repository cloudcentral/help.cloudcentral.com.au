---
title: Manage Shares using the dashboard
tags: [dashboard, share]
keywords: dashboard, share
last_updated: May 20, 2019
summary: "How to manage Shares using the dashboard"
sidebar: cloud_sidebar
permalink: cloud_dashboard_shares.html
folder: cloud
---

Shares can be created in order to provide NFS or CIFS (SMB) storage to instances on an internal network

1. [Login to the dashboard](cloud_dashboard_login.html).

1. Select the appropriate project from the drop down menu at the top left.

1. On the Project tab, open the Share Tag

## Create a Share Network

{% include note.html content="This step can be skipped if you already have a compatible Share Network." %}

1. Select the Share Networks tab, click Add Share Network

1. In the Add Share Network dialog box, enter the following values:

   * Name: A name for the Share Network
   * Description: A description for the Share Network
   * Neutron net: Select the internal network you want the share on

1. Click Add.

   The dashboard shows the Share Network

## Create a Share

1. Select the Shares tab, click Add Share

1. In the Add Share dialog box, enter the following values:

   * Name: A name for the Share
   * Description: A description for the Share
   * Share protocol: Select NFS or CIFS
   * Size (GB): Enter the required size
   * Share Type: Select the type of share to create
   * Availability Zone: Select the availability zone for the share
   * Share Group: Optionally select a share group
   * Metadata: Optionally add metadata for the share

1. Click Add.

   The dashboard shows the Share

## Grant access to the share

1. Select the Shares tab, click 'Manage Rules' in the 'Action' dropdown next to the Share

1. Click '+ Add Rule'

1. In the Add Rule dialog box, enter the following values:
  
   * Access Type: The type of access restriction (IP, User, Cert)
   * Access Level: The access level to the share (read-write, read-only)
   * Access To: What to grant access to, ie an IP address

1. Click Add.

   The dashboard shows the Share

## Mount the share on an instance
Log into your compute instance and create a folder where the mount will be placed:

```sh
$ mkdir ~/test_folder
```
Mount the NFS share in the compute instance using the export location of the share:

```sh
$ mount -vt nfs 10.254.0.6:/shares/share-0bfd69a1-27f0-4ef5-af17-7cd50bce6550 ~/test_folder
```


