---
title: Create and manage volumes
tags: [dashboard, volume]
keywords: dashboard, volume
last_updated: April 11, 2018
summary: "How to create and manage volumes for your instances"
sidebar: cloud_sidebar
permalink: cloud_dashboard_volumes.html
folder: cloud
---

Volumes are block storage devices that you attach to instances to enable persistent storage. You can attach a volume to a running instance or detach a volume and attach it to another instance at any time. You can also create a snapshot from or delete a volume.

## Create a volume
1. [Log in to the dashboard](cloud_dashboard_login.html).

1. Select the appropriate project from the drop down menu at the top left.

1. On the Project tab, open the Volumes tab and click Volumes category.

1. Click Create Volume.

1. In the dialog box that opens, enter or select the following values.

   - Volume Name: Specify a name for the volume.

   - Description: Optionally, provide a brief description for the volume.

   - Volume Source: Select one of the following options:

     - No source, empty volume: Creates an empty volume. An empty volume does not contain a file system or a partition table.
     - Snapshot: If you choose this option, a new field for Use snapshot as a source displays. You can select the snapshot from the list.
     - Image: If you choose this option, a new field for Use image as a source displays. You can select the image from the list.
     - Volume: If you choose this option, a new field for Use volume as a source displays. You can select the volume from the list. Options to use a snapshot or a volume as the source for a volume are displayed only if there are existing snapshots or volumes.

   - Type: Leave this field blank.

   - Size (GB): The size of the volume in gibibytes (GiB).

   - Availability Zone: Select the Availability Zone from the list. By default, this value is set to the availability zone given by the cloud provider (for example, us-west or apac-south). For some cases, it could be nova.

1. Click Create Volume.

   The dashboard shows the volume on the Volumes tab.

## Attach a volume to an instance
After you create one or more volumes, you can attach them to instances. You can attach a volume to one instance at a time.

1. [Log in to the dashboard](cloud_dashboard_login.html).

1. Select the appropriate project from the drop down menu at the top left.

1. On the Project tab, open the Volumes tab and click Volumes category.

1. Select the volume to add to an instance and click Manage Attachments.

1. In the Manage Volume Attachments dialog box, select an instance.

1. Enter the name of the device from which the volume is accessible by the instance.

   {% include note.html content="The actual device name might differ from the volume name because of hypervisor settings." %}

1. Click Attach Volume.

   The dashboard shows the instance to which the volume is now attached and the device name.

You can view the status of a volume in the Volumes tab of the dashboard. The volume is either Available or In-Use.

Now you can log in to the instance and mount, format, and use the disk.

## Detach a volume from an instance
1. [Log in to the dashboard](cloud_dashboard_login.html).
1. Select the appropriate project from the drop down menu at the top left.
1. On the Project tab, open the Volumes tab and click the Volumes category.
1. Select the volume and click Manage Attachments.
1. Click Detach Volume and confirm your changes.
A message indicates whether the action was successful.

## Create a snapshot from a volume
1. [Log in to the dashboard](cloud_dashboard_login.html).

1. Select the appropriate project from the drop down menu at the top left.

1. On the Project tab, open the Volumes tab and click Volumes category.

1. Select a volume from which to create a snapshot.

1. In the Actions column, click Create Snapshot.

1. In the dialog box that opens, enter a snapshot name and a brief description.

1. Confirm your changes.

   The dashboard shows the new volume snapshot in Volume Snapshots tab.

## Edit a volume
1. [Log in to the dashboard](cloud_dashboard_login.html).

1. Select the appropriate project from the drop down menu at the top left.

1. On the Project tab, open the Volumes tab and click Volumes category.

1. Select the volume that you want to edit.

1. In the Actions column, click Edit Volume.

1. In the Edit Volume dialog box, update the name and description of the volume.

1. Click Edit Volume.

   {% include note.html content="You can extend a volume by using the Extend Volume option available in the More dropdown list and entering the new value for volume size." %}

## Delete a volume
When you delete an instance, the data in its attached volumes is not deleted.

1. [Log in to the dashboard](cloud_dashboard_login.html).

1. Select the appropriate project from the drop down menu at the top left.

1. On the Project tab, open the Volumes tab and click Volumes category.

1. Select the check boxes for the volumes that you want to delete.

1. Click Delete Volumes and confirm your choice.

   A message indicates whether the action was successful.
