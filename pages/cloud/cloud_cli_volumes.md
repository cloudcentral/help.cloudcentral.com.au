---
title: Create and manage volumes using the CLI
tags: [cli, volumes]
keywords: cli, volume
last_updated: May 20, 2019
summary: "How to create adn manage volumes using the CLI"
sidebar: cloud_sidebar
permalink: cloud_cli_volumes.html
folder: cloud
---

A volume is a detachable block storage device, similar to a USB hard drive. You can attach a volume to only one instance. Use the openstack client commands to create and manage volumes.

## Create a volume
This example creates a my-new-volume volume based on an image.

1. List images, and note the ID of the image that you want to use for your volume:
   ```shell
   $ openstack image list
   +--------------------------------------+---------------------------------+
   | ID                                   | Name                            |
   +--------------------------------------+---------------------------------+
   | 8bf4dc2a-bf78-4dd1-aefa-f3347cf638c8 | cirros-0.3.4-x86_64-uec         |
   | 9ff9bb2e-3a1d-4d98-acb5-b1d3225aca6c | cirros-0.3.4-x86_64-uec-kernel  |
   | 4b227119-68a1-4b28-8505-f94c6ea4c6dc | cirros-0.3.4-x86_64-uec-ramdisk |
   +--------------------------------------+---------------------------------+
   ```
1. List the availability zones, and note the ID of the availability zone in which you want to create your volume:
   ```shell
   $ openstack availability zone list
   +------+-----------+
   | Name |   Status  |
   +------+-----------+
   | nova | available |
   +------+-----------+
   ```
1. Create a volume with 8 gibibytes (GiB) of space, and specify the availability zone and image:
   ```shell
   $ openstack volume create --image 8bf4dc2a-bf78-4dd1-aefa-f3347cf638c8 \
     --size 8 --availability-zone nova my-new-volume

   +------------------------------+--------------------------------------+
   | Property                     | Value                                |
   +------------------------------+--------------------------------------+
   | attachments                  | []                                   |
   | availability_zone            | nova                                 |
   | bootable                     | false                                |
   | consistencygroup_id          | None                                 |
   | created_at                   | 2016-09-23T07:52:42.000000           |
   | description                  | None                                 |
   | encrypted                    | False                                |
   | id                           | bab4b0e0-ce3d-4d57-bf57-3c51319f5202 |
   | metadata                     | {}                                   |
   | multiattach                  | False                                |
   | name                         | my-new-volume                        |
   | os-vol-tenant-attr:tenant_id | 3f670abbe9b34ca5b81db6e7b540b8d8     |
   | replication_status           | disabled                             |
   | size                         | 8                                    |
   | snapshot_id                  | None                                 |
   | source_volid                 | None                                 |
   | status                       | creating                             |
   | updated_at                   | None                                 |
   | user_id                      | fe19e3a9f63f4a14bd4697789247bbc5     |
   | volume_type                  | lvmdriver-1                          |
   +------------------------------+--------------------------------------+
   ```
1. To verify that your volume was created successfully, list the available volumes:
   ```shell
   $ openstack volume list
   +--------------------------------------+---------------+-----------+------+-------------+
   | ID                                   | DisplayName   |  Status   | Size | Attached to |
   +--------------------------------------+---------------+-----------+------+-------------+
   | bab4b0e0-ce3d-4d57-bf57-3c51319f5202 | my-new-volume | available | 8    |             |
   +--------------------------------------+---------------+-----------+------+-------------+
   ```
   If your volume was created successfully, its status is available. If its status is error, you might have exceeded your quota.

## Attach a volume to an instance
Attach your volume to a server, specifying the server ID and the volume ID:
```shell
$ openstack server add volume 84c6e57d-a6b1-44b6-81eb-fcb36afd31b5 \
  573e024d-5235-49ce-8332-be1576d323f8 --device /dev/vdb
```
Show information for your volume:
```shell
$ openstack volume show 573e024d-5235-49ce-8332-be1576d323f8
```
The output shows that the volume is attached to the server with ID 84c6e57d-a6b1-44b6-81eb-fcb36afd31b5, is in the nova availability zone, and is bootable.
```sh
+------------------------------+-----------------------------------------------+
| Field                        | Value                                         |
+------------------------------+-----------------------------------------------+
| attachments                  | [{u'device': u'/dev/vdb',                     |
|                              |        u'server_id': u'84c6e57d-a             |
|                              |           u'id': u'573e024d-...               |
|                              |        u'volume_id': u'573e024d...            |
| availability_zone            | nova                                          |
| bootable                     | true                                          |
| consistencygroup_id          | None                                          |
| created_at                   | 2016-10-13T06:08:07.000000                    |
| description                  | None                                          |
| encrypted                    | False                                         |
| id                           | 573e024d-5235-49ce-8332-be1576d323f8          |
| multiattach                  | False                                         |
| name                         | my-new-volume                                 |
| os-vol-tenant-attr:tenant_id | 7ef070d3fee24bdfae054c17ad742e28              |
| properties                   |                                               |
| replication_status           | disabled                                      |
| size                         | 8                                             |
| snapshot_id                  | None                                          |
| source_volid                 | None                                          |
| status                       | in-use                                        |
| type                         | lvmdriver-1                                   |
| updated_at                   | 2016-10-13T06:08:11.000000                    |
| user_id                      | 33fdc37314914796883706b33e587d51              |
| volume_image_metadata        |{u'kernel_id': u'df430cc2...,                  |
|                              |        u'image_id': u'397e713c...,            |
|                              |        u'ramdisk_id': u'3cf852bd...,          |
|                              |u'image_name': u'cirros-0.3.2-x86_64-uec'}     |
+------------------------------+-----------------------------------------------+
```
## Resize a volume
To resize your volume, you must first detach it from the server. To detach the volume from your server, pass the server ID and volume ID to the following command:
```shell
$ openstack server remove volume 84c6e57d-a6b1-44b6-81eb-fcb36afd31b5 573e024d-5235-49ce-8332-be1576d323f8
```
This command does not provide any output.

List volumes:
```shell
$ openstack volume list
+----------------+-----------------+-----------+------+-------------+
|       ID       |   Display Name  |  Status   | Size | Attached to |
+----------------+-----------------+-----------+------+-------------+
| 573e024d-52... |  my-new-volume  | available |  8   |             |
| bd7cf584-45... | my-bootable-vol | available |  8   |             |
+----------------+-----------------+-----------+------+-------------+
```
Note that the volume is now available.

Resize the volume by passing the volume ID and the new size (a value greater than the old one) as parameters:
```shell
$ openstack volume set 573e024d-5235-49ce-8332-be1576d323f8 --size 10
```
This command does not provide any output.

{% include note.html content="When extending an LVM volume with a snapshot, the volume will be deactivated. The reactivation is automatic unless auto_activation_volume_list is defined in lvm.conf. See lvm.conf for more information." %}

## Delete a volume
To delete your volume, you must first detach it from the server. To detach the volume from your server and check for the list of existing volumes, see steps 1 and 2 in Resize_a_volume.

Delete the volume using either the volume name or ID:
```shell
$ openstack volume delete my-new-volume
```
This command does not provide any output.

List the volumes again, and note that the status of your volume is deleting:
```shell
$ openstack volume list
+----------------+-----------------+-----------+------+-------------+
|       ID       |   Display Name  |  Status   | Size | Attached to |
+----------------+-----------------+-----------+------+-------------+
| 573e024d-52... |  my-new-volume  |  deleting |  8   |             |
| bd7cf584-45... | my-bootable-vol | available |  8   |             |
+----------------+-----------------+-----------+------+-------------+
```
When the volume is fully deleted, it disappears from the list of volumes:
```shell
$ openstack volume list
+----------------+-----------------+-----------+------+-------------+
|       ID       |   Display Name  |  Status   | Size | Attached to |
+----------------+-----------------+-----------+------+-------------+
| bd7cf584-45... | my-bootable-vol | available |  8   |             |
+----------------+-----------------+-----------+------+-------------+
```
## Transfer a volume
You can transfer a volume from one owner to another by using the cinder transfer\* commands. The volume donor, or original owner, creates a transfer request and sends the created transfer ID and authorization key to the volume recipient. The volume recipient, or new owner, accepts the transfer by using the ID and key.

{% include note.html content="The procedure for volume transfer is intended for tenants (both the volume donor and recipient) within the same cloud." %}

Use cases include:

  - Create a custom bootable volume or a volume with a large data set and transfer it to a customer.
  - For bulk import of data to the cloud, the data ingress system creates a new Block Storage volume, copies data from the physical device, and transfers device ownership to the end user.

### Create a volume transfer request

1. While logged in as the volume donor, list the available volumes:
   ```shell
   $ openstack volume list
   +-----------------+-----------------+-----------+------+-------------+
   |       ID        |   Display Name  |  Status   | Size | Attached to |
   +-----------------+-----------------+-----------+------+-------------+
   | 72bfce9f-cac... |       None      |   error   |  1   |             |
   | a1cdace0-08e... |       None      | available |  1   |             |
   +-----------------+-----------------+-----------+------+-------------+
   ```
1. As the volume donor, request a volume transfer authorization code for a specific volume:
   ```shell
     $ openstack volume transfer request create volume
   ```
   ```volume``` Name or ID of volume to transfer.

   The volume must be in an available state or the request will be denied. If the transfer request is valid in the database (that is, it has not expired or been deleted), the volume is placed in an awaiting-transfer state. For example:
   ```shell
   $ openstack volume transfer request create a1cdace0-08e4-4dc7-b9dc-457e9bcfe25f
   ```
   The output shows the volume transfer ID in the id row and the authorization key.
   ```shell
   +------------+--------------------------------------+
   | Field      | Value                                |
   +------------+--------------------------------------+
   | auth_key   | 0a59e53630f051e2                     |
   | created_at | 2016-11-03T11:49:40.346181           |
   | id         | 34e29364-142b-4c7b-8d98-88f765bf176f |
   | name       | None                                 |
   | volume_id  | a1cdace0-08e4-4dc7-b9dc-457e9bcfe25f |
   +------------+--------------------------------------+
   ```
   {% include note.html content="Optionally, you can specify a name for the transfer by using the --name transferName parameter." %}

   {% include note.html content="While the auth_key property is visible in the output of openstack volume transfer request create VOLUME_ID, it will not be available in subsequent openstack volume transfer request show TRANSFER_ID command." %}

   Send the volume transfer ID and authorization key to the new owner (for example, by email).

1. View pending transfers:
   ```shell
   $ openstack volume transfer request list
   +--------------------------------------+--------------------------------------+------+
   |               ID                     |             Volume                   | Name |
   +--------------------------------------+--------------------------------------+------+
   | 6e4e9aa4-bed5-4f94-8f76-df43232f44dc | a1cdace0-08e4-4dc7-b9dc-457e9bcfe25f | None |
   +--------------------------------------+--------------------------------------+------+
   ```
1. After the volume recipient, or new owner, accepts the transfer, you can see that the transfer is no longer available:
   ```shell
   $ openstack volume transfer request list
   +----+-----------+------+
   | ID | Volume ID | Name |
   +----+-----------+------+
   +----+-----------+------+
   ```

### Accept a volume transfer request
As the volume recipient, you must first obtain the transfer ID and authorization key from the original owner.

Accept the request:
```shell
$ openstack volume transfer request accept transferID authKey
```
For example:
```shell
$ openstack volume transfer request accept 6e4e9aa4-bed5-4f94-8f76-df43232f44dc b2c8e585cbc68a80
+-----------+--------------------------------------+
|  Property |                Value                 |
+-----------+--------------------------------------+
|     id    | 6e4e9aa4-bed5-4f94-8f76-df43232f44dc |
|    name   |                 None                 |
| volume_id | a1cdace0-08e4-4dc7-b9dc-457e9bcfe25f |
+-----------+--------------------------------------+
```
{% include note.html content="If you do not have a sufficient quota for the transfer, the transfer is refused." %}

### Delete a volume transfer
1. List available volumes and their statuses:
   ```shell
   $ openstack volume list
   +-----------------+-----------------+-----------------+------+-------------+
   |       ID        |   Display Name  |      Status     | Size | Attached to |
   +-----------------+-----------------+-----------------+------+-------------+
   | 72bfce9f-cac... |       None      |      error      |  1   |             |
   | a1cdace0-08e... |       None      |awaiting-transfer|  1   |             |
   +-----------------+-----------------+-----------------+------+-------------+
   ```
1. Find the matching transfer ID:
   ```shell
   $ openstack volume transfer request list
   +--------------------------------------+--------------------------------------+------+
   |               ID                     |             VolumeID                 | Name |
   +--------------------------------------+--------------------------------------+------+
   | a6da6888-7cdf-4291-9c08-8c1f22426b8a | a1cdace0-08e4-4dc7-b9dc-457e9bcfe25f | None |
   +--------------------------------------+--------------------------------------+------+
   ```
1. Delete the volume:
   ```shell
   $ openstack volume transfer request delete transfer
   ```
   ```transfer``` Name or ID of transfer to delete.

   For example:
   ```shell
   $ openstack volume transfer request delete a6da6888-7cdf-4291-9c08-8c1f22426b8a
   ```
1. Verify that transfer list is now empty and that the volume is again available for transfer:
   ```shell
   $ openstack volume transfer request list
   +----+-----------+------+
   | ID | Volume ID | Name |
   +----+-----------+------+
   +----+-----------+------+
   $ openstack volume list
   +-----------------+-----------+--------------+------+-------------+----------+-------------+
   |       ID        |   Status  | Display Name | Size | Volume Type | Bootable | Attached to |
   +-----------------+-----------+--------------+------+-------------+----------+-------------+
   | 72bfce9f-ca...  |   error   |     None     |  1   |     None    |  false   |             |
   | a1cdace0-08...  | available |     None     |  1   |     None    |  false   |             |
   +-----------------+-----------+--------------+------+-------------+----------+-------------+
   ```

## Manage and unmanage a snapshot
A snapshot is a point in time version of a volume. As an administrator, you can manage and unmanage snapshots.

### Manage a snapshot
Manage a snapshot with the cinder snapshot-manage command:
```shell
$ openstack snapshot set \
  [--name <name>] \
  [--description <description>] \
  [--property <key=value> [...] ] \
  [--state <state>] \
  <snapshot>
```
The arguments to be passed are:

- ```--name```
  - New snapshot name
- ```--description```
  - New snapshot description
- ```--property```
  - Property to add or modify for this snapshot (repeat option to set multiple properties)
- ```--state```
  - New snapshot state. (“available”, “error”, “creating”, “deleting”, or “error_deleting”) (admin only) (This option simply changes the state of the snapshot in the database with no regard to actual status, exercise caution when using)
- ```snapshot```
   - Snapshot to modify (name or ID)

```shell
$ openstack snapshot set my-snapshot-id
```

### Unmanage a snapshot
Unmanage a snapshot with the cinder snapshot-unmanage command:
```shell
$ openstack snapshot unset SNAPSHOT
```
The arguments to be passed are:

- ```SNAPSHOT```
  - Name or ID of the snapshot to unmanage.

The following example unmanages the my-snapshot-id image:
```shell
$ openstack snapshot unset my-snapshot-id
```
