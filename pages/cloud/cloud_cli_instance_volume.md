---
title: Create and instance from a volume using the CLI
tags: [cli, volume]
keywords: cli, volume
last_updated: April 11, 2018
summary: "How to create an instance from a volume using the CLI"
sidebar: cloud_sidebar
permalink: cloud_cli_instance_volume.html
folder: cloud
---

You can boot instances from a volume instead of an image.

To complete these tasks, use these parameters on the nova boot command:

| Task | nova boot parameter | Information |
|-----|---------------------|-----------|
|Boot an instance from an image and attach a non-bootable volume.|--block-device|Boot instance from image and attach non-bootable volume|
|Create a volume from an image and boot an instance from that volume.| --block-device|Create volume from image and boot instance|
|Boot from an existing source image, volume, or snapshot.|--block-device|Create volume from image and boot instance|
|Attach a swap disk to an instance.|--swap|Attach swap or ephemeral disk to an instance|
|Attach an ephemeral disk to an instance.|--ephemeral|Attach swap or ephemeral disk to an instance|

{% include note.html content="To attach a volume to a running instance, see Attach a volume to an instance." %}

## Boot instance from image and attach non-bootable volume {#boot}
Create a non-bootable volume and attach that volume to an instance that you boot from an image.

To create a non-bootable volume, do not create it from an image. The volume must be entirely empty with no partition table and no file system.

1. Create a non-bootable volume.
   ```sh
   $ cinder create --display-name my-volume 8
   +--------------------------------+--------------------------------------+
   |            Property            |                Value                 |
   +--------------------------------+--------------------------------------+
   |          attachments           |                  []                  |
   |       availability_zone        |                 nova                 |
   |            bootable            |                false                 |
   |           created_at           |      2014-05-09T16:33:11.000000      |
   |          description           |                 None                 |
   |           encrypted            |                False                 |
   |               id               | d620d971-b160-4c4e-8652-2513d74e2080 |
   |            metadata            |                  {}                  |
   |              name              |              my-volume               |
   |     os-vol-host-attr:host      |                 None                 |
   | os-vol-mig-status-attr:migstat |                 None                 |
   | os-vol-mig-status-attr:name_id |                 None                 |
   |  os-vol-tenant-attr:tenant_id  |   ccef9e62b1e645df98728fb2b3076f27   |
   |              size              |                  8                   |
   |          snapshot_id           |                 None                 |
   |          source_volid          |                 None                 |
   |             status             |               creating               |
   |            user_id             |   fef060ae7bfd4024b3edb97dff59017a   |
   |          volume_type           |                 None                 |
   +--------------------------------+--------------------------------------+
   ```
1. List volumes.
   ```sh
   $ cinder list
   +-----------------+-----------+-----------+------+-------------+----------+-------------+
   |       ID        |   Status  |    Name   | Size | Volume Type | Bootable | Attached to |
   +-----------------+-----------+-----------+------+-------------+----------+-------------+
   | d620d971-b16... | available | my-volume |  8   |     None    |  false   |             |
   +-----------------+-----------+-----------+------+-------------+----------+-------------+
   ```
1. Boot an instance from an image and attach the empty volume to the instance.
   ```sh
   $ nova boot --flavor 2 --image 98901246-af91-43d8-b5e6-a4506aa8f369 \
     --block-device source=volume,id=d620d971-b160-4c4e-8652-2513d74e2080,dest=volume,shutdown=preserve \
     myInstanceWithVolume
   +--------------------------------------+--------------------------------------------+
   | Property                             | Value                                      |
   +--------------------------------------+--------------------------------------------+
   | OS-DCF:diskConfig                    | MANUAL                                     |
   | OS-EXT-AZ:availability_zone          | nova                                       |
   | OS-EXT-SRV-ATTR:host                 | -                                          |
   | OS-EXT-SRV-ATTR:hypervisor_hostname  | -                                          |
   | OS-EXT-SRV-ATTR:instance_name        | instance-00000004                          |
   | OS-EXT-STS:power_state               | 0                                          |
   | OS-EXT-STS:task_state                | scheduling                                 |
   | OS-EXT-STS:vm_state                  | building                                   |
   | OS-SRV-USG:launched_at               | -                                          |
   | OS-SRV-USG:terminated_at             | -                                          |
   | accessIPv4                           |                                            |
   | accessIPv6                           |                                            |
   | adminPass                            | ZaiYeC8iucgU                               |
   | config_drive                         |                                            |
   | created                              | 2014-05-09T16:34:50Z                       |
   | flavor                               | m1.small (2)                               |
   | hostId                               |                                            |
   | id                                   | 1e1797f3-1662-49ff-ae8c-a77e82ee1571       |
   | image                                | cirros-0.3.1-x86_64-uec (98901246-af91-... |
   | key_name                             | -                                          |
   | metadata                             | {}                                         |
   | name                                 | myInstanceWithVolume                       |
   | os-extended-volumes:volumes_attached | [{"id": "d620d971-b160-4c4e-8652-2513d7... |
   | progress                             | 0                                          |
   | security_groups                      | default                                    |
   | status                               | BUILD                                      |
   | tenant_id                            | ccef9e62b1e645df98728fb2b3076f27           |
   | updated                              | 2014-05-09T16:34:51Z                       |
   | user_id                              | fef060ae7bfd4024b3edb97dff59017a           |
   +--------------------------------------+--------------------------------------------+
   ```

## Create volume from image and boot instance {#image}
You can create a volume from an existing image, volume, or snapshot. This procedure shows you how to create a volume from an image, and use the volume to boot an instance.

1. List the available images.
   ```sh
   $ openstack image list
   +-----------------+---------------------------------+--------+
   | ID              | Name                            | Status |
   +-----------------+---------------------------------+--------+
   | 484e05af-a14... | Fedora-x86_64-20-20131211.1-sda | active |
   | 98901246-af9... | cirros-0.3.1-x86_64-uec         | active |
   | b6e95589-7eb... | cirros-0.3.1-x86_64-uec-kernel  | active |
   | c90893ea-e73... | cirros-0.3.1-x86_64-uec-ramdisk | active |
   +-----------------+---------------------------------+--------+
   ```
   Note the ID of the image that you want to use to create a volume.

   If you want to create a volume to a specific storage backend, you need to use an image which has cinder_img_volume_type property. In this case, a new volume will be created as storage_backend1 volume type.
   ```sh
   $ openstack image show 98901246-af9...
   +------------------+------------------------------------------------------+
   | Field            | Value                                                |
   +------------------+------------------------------------------------------+
   | checksum         | ee1eca47dc88f4879d8a229cc70a07c6                     |
   | container_format | bare                                                 |
   | created_at       | 2016-10-08T14:59:05Z                                 |
   | disk_format      | qcow2                                                |
   | file             | /v2/images/9fef3b2d-c35d-4b61-bea8-09cc6dc41829/file |
   | id               | 98901246-af9d-4b61-bea8-09cc6dc41829                 |
   | min_disk         | 0                                                    |
   | min_ram          | 0                                                    |
   | name             | cirros-0.3.4-x86_64-uec                              |
   | owner            | 8d8ef3cdf2b54c25831cbb409ad9ae86                     |
   | protected        | False                                                |
   | schema           | /v2/schemas/image                                    |
   | size             | 13287936                                             |
   | status           | active                                               |
   | tags             |                                                      |
   | updated_at       | 2016-10-19T09:12:52Z                                 |
   | virtual_size     | None                                                 |
   | visibility       | public                                               |
   +------------------+------------------------------------------------------+
   ```
1. List the available flavors.
   ```sh
   $ openstack flavor list
   +-----+-----------+-------+------+-----------+-------+-----------+
   | ID  | Name      |   RAM | Disk | Ephemeral | VCPUs | Is_Public |
   +-----+-----------+-------+------+-----------+-------+-----------+
   | 1   | m1.tiny   |   512 |    1 |         0 |     1 | True      |
   | 2   | m1.small  |  2048 |   20 |         0 |     1 | True      |
   | 3   | m1.medium |  4096 |   40 |         0 |     2 | True      |
   | 4   | m1.large  |  8192 |   80 |         0 |     4 | True      |
   | 5   | m1.xlarge | 16384 |  160 |         0 |     8 | True      |
   +-----+-----------+-------+------+-----------+-------+-----------+
   ```
   Note the ID of the flavor that you want to use to create a volume.

1. To create a bootable volume from an image and launch an instance from this volume, use the --block-device parameter.

   For example:
   ```sh
   $ nova boot --flavor FLAVOR --block-device \
     source=SOURCE,id=ID,dest=DEST,size=SIZE,shutdown=PRESERVE,bootindex=INDEX \
     NAME
   ```
   The parameters are:

   - ```--flavor``` FLAVOR. The flavor ID or name.

   - ```--block-device``` source=SOURCE,id=ID,dest=DEST,size=SIZE,shutdown=PRESERVE,bootindex=INDEX

     source=SOURCE
     - The type of object used to create the block device. Valid values are volume, snapshot, image, and blank.

     id=ID
     - The ID of the source object.

     dest=DEST
     - The type of the target virtual device. Valid values are volume and local.

     size=SIZE
     - The size of the volume that is created.

     shutdown={preserve|remove}
     - What to do with the volume when the instance is deleted. preserve does not delete the volume. remove deletes the volume.

     bootindex=INDEX
     - Orders the boot disks. Use 0 to boot from this volume.

  - ```NAME```. The name for the server.

1. Create a bootable volume from an image. Cinder makes a volume bootable when --image-id parameter is passed.
   ```sh
   $ cinder create --image-id $IMAGE_ID --display_name=bootable_volume $SIZE_IN_GB
   ```
1. Create a VM from previously created bootable volume. The volume is not deleted when the instance is terminated.
   ```sh
   $ nova boot --flavor 2 \
     --block-device source=volume,id=$VOLUME_ID,dest=volume,size=10,shutdown=preserve,bootindex=0 \
     myInstanceFromVolume
   +--------------------------------------+--------------------------------+
   | Property                             | Value                          |
   +--------------------------------------+--------------------------------+
   | OS-EXT-STS:task_state                | scheduling                     |
   | image                                | Attempt to boot from volume    |
   |                                      | - no image supplied            |
   | OS-EXT-STS:vm_state                  | building                       |
   | OS-EXT-SRV-ATTR:instance_name        | instance-00000003              |
   | OS-SRV-USG:launched_at               | None                           |
   | flavor                               | m1.small                       |
   | id                                   | 2e65c854-dba9-4f68-8f08-fe3... |
   | security_groups                      | [{u'name': u'default'}]        |
   | user_id                              | 352b37f5c89144d4ad053413926... |
   | OS-DCF:diskConfig                    | MANUAL                         |
   | accessIPv4                           |                                |
   | accessIPv6                           |                                |
   | progress                             | 0                              |
   | OS-EXT-STS:power_state               | 0                              |
   | OS-EXT-AZ:availability_zone          | nova                           |
   | config_drive                         |                                |
   | status                               | BUILD                          |
   | updated                              | 2014-02-02T13:29:54Z           |
   | hostId                               |                                |
   | OS-EXT-SRV-ATTR:host                 | None                           |
   | OS-SRV-USG:terminated_at             | None                           |
   | key_name                             | None                           |
   | OS-EXT-SRV-ATTR:hypervisor_hostname  | None                           |
   | name                                 | myInstanceFromVolume           |
   | adminPass                            | TzjqyGsRcJo9                   |
   | tenant_id                            | f7ac731cc11f40efbc03a9f9e1d... |
   | created                              | 2014-02-02T13:29:53Z           |
   | os-extended-volumes:volumes_attached | [{"id": "2fff50ab..."}]        |
   | metadata                             | {}                             |
   +--------------------------------------+--------------------------------+
   ```
6. List volumes to see the bootable volume and its attached myInstanceFromVolume instance.
   ```sh
   $ cinder list
   +-------------+--------+-----------------+------+-------------+----------+-------------+
   |      ID     | Status | Display Name    | Size | Volume Type | Bootable | Attached to |
   +-------------+--------+-----------------+------+-------------+----------+-------------+
   | 2fff50ab... | in-use | bootable_volume |  10  |     None    |   true   | 2e65c854... |
   +-------------+--------+-----------------+------+-------------+----------+-------------+
   ```

## Attach swap or ephemeral disk to an instance {#ephemeral}
Use the nova boot --swap parameter to attach a swap disk on boot or the nova boot --ephemeral parameter to attach an ephemeral disk on boot. When you terminate the instance, both disks are deleted.

Boot an instance with a 512 MB swap disk and 2 GB ephemeral disk.
```sh
$ nova boot --flavor FLAVOR --image IMAGE_ID --swap 512 --ephemeral size=2 NAME
```
{% include note.html content="The flavor defines the maximum swap and ephemeral disk size. You cannot exceed these maximum values." %}
