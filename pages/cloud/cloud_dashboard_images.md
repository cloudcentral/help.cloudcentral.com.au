---
title: Upload and manage images
tags: [dashboard, image]
keywords: dashboard, image, upload
last_updated: May 20, 2019
summary: "How to upload an image for your instances to use"
sidebar: cloud_sidebar
permalink: cloud_dashboard_images.html
folder: cloud
---

A virtual machine image, referred to in this document simply as an image, is a single file that contains a virtual disk that has a bootable operating system installed on it. Images are used to create virtual machine instances within the cloud. For information about creating image files, see the OpenStack Virtual Machine Image Guide.

Depending on your role, you may have permission to upload and manage virtual machine images. Operators might restrict the upload and management of images to cloud administrators or operators only. If you have the appropriate privileges, you can use the dashboard to upload and manage images in the admin project.

{% include note.html content="You can also use the openstack and glance command-line clients or the Image service to manage images. For more information see [Manage images](cloud_cli_images.html)." %}

## Upload an image
Follow this procedure to upload an image to a project:

1. [Log in to the dashboard](cloud_dashboard_login.html).

1. Select the appropriate project from the drop down menu at the top left.

1. On the Project tab, open the Compute tab and click Images category.

1. Click Create Image.

   The Create An Image dialog box appears.

   {% include image.html file="create_image.png" alt="Create Image" caption="Dashboard - Create Image" %}

1. Enter the following values:

   |Name|Enter a name for the image.|
   |Description|Enter a brief description of the image.|
   |Image Source|Choose the image source from the dropdown list. Your choices are Image Location and Image File.|
   |Image File or Image Location|Based on your selection for Image Source, you either enter the location URL of the image in the Image Location field, or browse for the image file on your file system and add it.|
   |Format|Select the image format (for example, QCOW2) for the image.|
   |Architecture|Specify the architecture. For example, i386 for a 32-bit architecture or x86_64 for a 64-bit architecture.|
   |Minimum Disk (GB)|Leave this field empty.|
   |Minimum RAM (MB)|Leave this field empty.|
   |Copy Data|Specify this option to copy image data to the Image service.|
   |Public|Select this check box to make the image public to all users with access to the current project.|
   |Protected|Select this check box to ensure that only users with permissions can delete the image.|

1. Click Create Image.

   The image is queued to be uploaded. It might take some time before the status changes from Queued to Active.

## Update an image
Follow this procedure to update an existing image.

1. [Log in to the dashboard](cloud_dashboard_login.html).
1. Select the appropriate project from the drop down menu at the top left.
1. Select the image that you want to edit.
1. In the Actions column, click the menu button and then select Edit Image from the list.
1. In the Edit Image dialog box, you can perform various actions. For example:
   * Change the name of the image.
   * Change the description of the image.
   * Change the format of the image.
   * Change the minimum disk of the image.
   * Change the minimum RAM of the image.
   * Select the Public button to make the image public.
   * Clear the Private button to make the image private.
   * Change the metadata of the image.
1. Click Edit Image.

## Delete an image
Deletion of images is permanent and cannot be reversed. Only users with the appropriate permissions can delete images.

1. [Log in to the dashboard](cloud_dashboard_login.html).
1. Select the appropriate project from the drop down menu at the top left.
1. On the Project tab, open the Compute tab and click Images category.
1. Select the images that you want to delete.
1. Click Delete Images.
1. In the Confirm Delete Images dialog box, click Delete Images to confirm the deletion.
