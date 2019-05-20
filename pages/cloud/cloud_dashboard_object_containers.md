---
title: Create and manage object containers
tags: [dashboard, object, storage]
keywords: dashboard, object
last_updated: April 11, 2018
summary: "How to create and manage object containers"
sidebar: cloud_sidebar
permalink: cloud_dashboard_object_containers.html
folder: cloud
---

OpenStack Object Storage (swift) is used for redundant, scalable data storage using clusters of standardized servers to store petabytes of accessible data. It is a long-term storage system for large amounts of static data which can be retrieved and updated.

OpenStack Object Storage provides a distributed, API-accessible storage platform that can be integrated directly into an application or used to store any type of file, including VM images, backups, archives, or media files. In the OpenStack dashboard, you can only manage containers and objects.

In OpenStack Object Storage, containers provide storage for objects in a manner similar to a Windows folder or Linux file directory, though they cannot be nested. An object in OpenStack consists of the file to be stored in the container and any accompanying metadata.

## Create a container
1. [Log in to the dashboard](cloud_dashboard_login.html).
1. Select the appropriate project from the drop down menu at the top left.
1. On the Project tab, open the Object Store tab and click Containers category.
1. Click Container.
1. In the Create Container dialog box, enter a name for the container, and then click Create.
You have successfully created a container.

{% include note.html content="To delete a container, click the More button and select Delete Container." %}

## Upload an object
1. [Log in to the dashboard](cloud_dashboard_login.html).

1. Select the appropriate project from the drop down menu at the top left.

1. On the Project tab, open the Object Store tab and click Containers category.

1. Select the container in which you want to store your object.

1. Click the Upload File icon.

   The Upload File To Container: ``<name>`` dialog box appears. ``<name>`` is the name of the container to which you are uploading the object.

1. Enter a name for the object.

1. Browse to and select the file that you want to upload.

1. Click Upload File.

You have successfully uploaded an object to the container.

{% include note.html content="To delete an object, click the More button and select Delete Object." %}

## Manage an object
**To edit an object**

1. [Log in to the dashboard](cloud_dashboard_login.html).

1. Select the appropriate project from the drop down menu at the top left.

1. On the Project tab, open the Object Store tab and click Containers category.

1. Select the container in which you want to store your object.

1. Click the menu button and choose Edit from the dropdown list.

   The Edit Object dialog box is displayed.

1. Browse to and select the file that you want to upload.

1. Click Update Object.

{% include note.html content="To delete an object, click the menu button and select Delete Object." %}

**To copy an object from one container to another**

1. [Log in to the dashboard](cloud_dashboard_login.html).
1. Select the appropriate project from the drop down menu at the top left.
1. On the Project tab, open the Object Store tab and click Containers category.
1. Select the container in which you want to store your object.
1. Click the menu button and choose Copy from the dropdown list.
1. In the Copy Object launch dialog box, enter the following values:
   - Destination Container: Choose the destination container from the list.
   - Path: Specify a path in which the new copy should be stored inside of the selected container.
   - Destination object name: Enter a name for the object in the new container.
1. Click Copy Object.

**To create a metadata-only object without a file**

You can create a new object in container without a file available and can upload the file later when it is ready. This temporary object acts a place-holder for a new object, and enables the user to share object metadata and URL info in advance.

1. [Log in to the dashboard](cloud_dashboard_login.html).

1. Select the appropriate project from the drop down menu at the top left.

1. On the Project tab, open the Object Store tab and click Containers category.

1. Select the container in which you want to store your object.

1. Click Upload Object.

1. The Upload Object To Container: ``<name>`` dialog box is displayed.

   ``<name>`` is the name of the container to which you are uploading the object.

1. Enter a name for the object.

1. Click Update Object.

**To create a pseudo-folder**

Pseudo-folders are similar to folders in your desktop operating system. They are virtual collections defined by a common prefix on the object’s name.

1. [Log in to the dashboard](cloud_dashboard_login.html).

1. Select the appropriate project from the drop down menu at the top left.

1. On the Project tab, open the Object Store tab and click Containers category.

1. Select the container in which you want to store your object.

1. Click Create Pseudo-folder.

   The Create Pseudo-Folder in Container ``<name>`` dialog box is displayed.

   ``<name>`` is the name of the container to which you are uploading the object.

1. Enter a name for the pseudo-folder.

   A slash (/) character is used as the delimiter for pseudo-folders in Object Storage.

1. Click Create.
