---
title: Manage images using the CLI
tags: [cli, image]
keywords: cli, image
last_updated: April 11, 2018
summary: "How to create and manage images using the CLI"
sidebar: cloud_sidebar
permalink: cloud_cli_images.html
published: false
folder: cloud
---

The cloud operator assigns roles to users. Roles determine who can upload and manage images. The operator might restrict image upload and management to only cloud administrators or operators.

You can upload images through the glance client or the Image service API. You can use the nova client for the image management. The latter provides mechanisms to list and delete images, set and delete image metadata, and create images of a running instance or snapshot and backup types.

After you upload an image, you cannot change it.

For details about image creation, see the Virtual Machine Image Guide.

## List or get details for images
To get a list of images and to get further details about a single image, use openstack image list and openstack image show commands.

```
$ openstack image list
+--------------------------------------+---------------------------------+--------+
| ID                                   | Name                            | Status |
+--------------------------------------+---------------------------------+--------+
| dfc1dfb0-d7bf-4fff-8994-319dd6f703d7 | cirros-0.3.2-x86_64-uec         | active |
| a3867e29-c7a1-44b0-9e7f-10db587cad20 | cirros-0.3.2-x86_64-uec-kernel  | active |
| 4b916fba-6775-4092-92df-f41df7246a6b | cirros-0.3.2-x86_64-uec-ramdisk | active |
| d07831df-edc3-4817-9881-89141f9134c3 | myCirrosImage                   | active |
+--------------------------------------+---------------------------------+--------+
$ openstack image show myCirrosImage
+------------------+------------------------------------------------------+
| Field            | Value                                                |
+------------------+------------------------------------------------------+
| checksum         | ee1eca47dc88f4879d8a229cc70a07c6                     |
| container_format | ami                                                  |
| created_at       | 2016-08-11T15:07:26Z                                 |
| disk_format      | ami                                                  |
| file             | /v2/images/dfc1dfb0-d7bf-4fff-8994-319dd6f703d7/file |
| id               | dfc1dfb0-d7bf-4fff-8994-319dd6f703d7                 |
| min_disk         | 0                                                    |
| min_ram          | 0                                                    |
| name             | myCirrosImage                                        |
| owner            | d88310717a8e4ebcae84ed075f82c51e                     |
| protected        | False                                                |
| schema           | /v2/schemas/image                                    |
| size             | 13287936                                             |
| status           | active                                               |
| tags             |                                                      |
| updated_at       | 2016-08-11T15:20:02Z                                 |
| virtual_size     | None                                                 |
| visibility       | private                                              |
+------------------+------------------------------------------------------+
```

When viewing a list of images, you can also use grep to filter the list, as follows:

```
$ openstack image list | grep 'cirros'
| dfc1dfb0-d7bf-4fff-8994-319dd6f703d7 | cirros-0.3.2-x86_64-uec         | active |
| a3867e29-c7a1-44b0-9e7f-10db587cad20 | cirros-0.3.2-x86_64-uec-kernel  | active |
| 4b916fba-6775-4092-92df-f41df7246a6b | cirros-0.3.2-x86_64-uec-ramdisk | active |
```

## Create or update an image
To create an image, use openstack image create:

```
$ openstack image create imageName
```

To update an image by name or ID, use openstack image set:

```
$ openstack image set imageName
```

The following list explains the optional arguments that you can use with the create and set commands to modify image properties. For more information, refer to Image service chapter in the OpenStack Command-Line Interface Reference.

- ```--name NAME```
  - The name of the image.
- ```--disk-format DISK_FORMAT```
  - The disk format of the image. Acceptable formats are ami, ari, aki, vhd, vhdx, vmdk, raw, qcow2, vdi, and iso.
- ```--container-format CONTAINER_FORMAT
  - The container format of the image. Acceptable formats are ami, ari, aki, bare, docker, ova, and ovf.
- ```--owner TENANT_ID --size SIZE```
  - The tenant who should own the image. The size of image data, in bytes.
- ```--min-disk DISK_GB```
  - The minimum size of the disk needed to boot the image, in gigabytes.
- ```--min-ram DISK_RAM```
  - The minimum amount of RAM needed to boot the image, in megabytes.
- ```--location IMAGE_URL```
  - The URL where the data for this image resides. This option is only available in V1 API. When using it, you also need to set --os-image-api-version. For example, if the image data is stored in swift, you could specify --os-image-api-version 1 --location swift://account:key@example.com/container/obj.
- ```--file FILE```
  - Local file that contains the disk image to be uploaded during the update. Alternatively, you can pass images to the client through stdin.
- ```--checksum CHECKSUM```
  - Hash of image data to use for verification.
- ```--copy-from IMAGE_URL```
  - Similar to --location in usage, but indicates that the image server should immediately copy the data and store it in its configured image store.
- ```--is-public [True|False]```
  - Makes an image accessible for all the tenants (admin-only by default).
- ```--is-protected [True|False]```
  - Prevents an image from being deleted.
- ```--property KEY=VALUE```
  - Arbitrary property to associate with image. This option can be used multiple times.
- ```--purge-props```
  - Deletes all image properties that are not explicitly set in the update request. Otherwise, those properties not referenced are preserved.
- ```--human-readable```
  - Prints the image size in a human-friendly format.
The following example shows the command that you would use to upload a CentOS 6.3 image in qcow2 format and configure it for public access:

```
$ openstack image create --disk-format qcow2 --container-format bare \
  --public --file ./centos63.qcow2 centos63-image
```

### Create an image from ISO image
You can upload ISO images to the Image service. You can subsequently boot an ISO image using Compute.

In the Image service, run the following command:

```
$ openstack image create ISO_IMAGE --file IMAGE.iso \
  --disk-format iso --container-format bare
```

Optionally, to confirm the upload in Image service, run:

```
$ openstack image list
```
