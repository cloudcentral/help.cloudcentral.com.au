---
title: Cloud Platform Images FAQ
permalink: cloud_faq_images.html
sidebar: cloud_sidebar
tags: cloud, faq
keywords: frequently asked questions, FAQ, question and answer, collapsible sections, expand, collapse
last_updated: May 20, 2019
summary: "Frequently asked questions regarding the Cloud Platform Images"
toc: false
folder: cloud
---

<div class="panel-group" id="accordion">
                    <div class="panel panel-default">
                        <div class="panel-heading">
                            <h4 class="panel-title">
                                <a class="nocrossref accordion-toggle" data-toggle="collapse" data-parent="#accordion" href="#collapseOneImages">Servers spawned from my own image do not respond to a resize</a>
                            </h4>
                        </div>
                        <div id="collapseOneImages" class="panel-collapse collapse">
                            <div class="panel-body">
<div markdown="1">
If your servers spawned from your own image don't resize or keep the status resize_prep then they do not shutdown correctly and don't respond to ACPI requests Openstack sends.

First shut down the VM and then retry the resize.

Make sure that the following kernel module is loaded:
```
acpiphp
```
This is the kernel module that handles the shutdown requests and such.
</div>
                            </div>
                        </div>
                    </div>
                    <!-- /.panel -->
                    <div class="panel panel-default">
                        <div class="panel-heading">
                            <h4 class="panel-title">
                                <a class="nocrossref accordion-toggle" data-toggle="collapse" data-parent="#accordion" href="#collapseTwoImages">My own image does not see the disk or the network card?</a>
                            </h4>
                        </div>
                        <div id="collapseTwoImages" class="panel-collapse collapse">
                            <div class="panel-body">
<div markdown="1">
Make sure your image has VirtIO Disk and NIC support.

We don't support any other formats like IDE, SATA or e1000.
</div>
                            </div>
                        </div>
                    </div>
                    <!-- /.panel -->

                    <div class="panel panel-default">
                        <div class="panel-heading">
                            <h4 class="panel-title">
                                <a class="nocrossref accordion-toggle" data-toggle="collapse" data-parent="#accordion" href="#collapseThreeImages">How do I upload an image</a>
                            </h4>
                        </div>
                        <div id="collapseThreeImages" class="panel-collapse collapse">
                            <div class="panel-body">
<div markdown="1">
* [Login to the Dashboard][cloud_dashboard_login]
* Navigate to: Images
* Click "Upload Image"
* Enter the required parameters:
  * Image Name
  * Type (QCOW2, RAW, VHD, VMDK, VDI, ISO9660)
  * Cloud Init support (Does this image allow openstack to set the password and ssh key via cloud-init?)
  * Minimum Disk
  * Minimum RAM
  * Image file
* Click "Upload Image"
* Wait for the upload to finish.
</div>
                            </div>
                        </div>
                    </div>
                    <!-- /.panel -->

                    <div class="panel panel-default">
                        <div class="panel-heading">
                            <h4 class="panel-title">
                                <a class="nocrossref accordion-toggle" data-toggle="collapse" data-parent="#accordion" href="#collapseFourImages">How do I get my SSH key in my own image?</a>
                            </h4>
                        </div>
                        <div id="collapseFourImages" class="panel-collapse collapse">
                            <div class="panel-body">
<div markdown="1">
The image you create should have support for cloud-init.

This is the program that changes the user password, ssh key and makes sure resizes work better.

When you are installing the image, make sure it is installed along.

Follow the steps in their [documentation](http://cloudinit.readthedocs.org/en/latest/) to configure it.
</div>
                            </div>
                        </div>
                    </div>
                    <!-- /.panel -->

                    <div class="panel panel-default">
                        <div class="panel-heading">
                            <h4 class="panel-title">
                                <a class="nocrossref accordion-toggle" data-toggle="collapse" data-parent="#accordion" href="#collapseFiveImages">How do I boot my own iso with a volume as root disk?</a>
                            </h4>
                        </div>
                        <div id="collapseFiveImages" class="panel-collapse collapse">
                            <div class="panel-body">
<div markdown="1">
First make sure you have an ISO present to upload, for example, FreeBSD:
```sh
wget http://ftp.freebsd.org/pub/FreeBSD/releases/amd64/amd64/ISO-IMAGES/10.0/FreeBSD-10.0-RELEASE-amd64-disc1.iso
```
Make sure then OS has VirtIO disk and VirtIO NIC support.

* Upload it to Openstack:
```sh
glance image-create --file FreeBSD-10.0-RELEASE-amd64-disc1.iso --name "FreeBSD-10.0-RELEASE-amd64-disc1.iso" --disk-format iso --container-format bare --progress
```
* Create the root volume:
```sh
cinder create --display-name "freebsd-10-root" 8
```
* Now boot a new instance with the ISO and the newly created root volume:
```sh
nova boot --image <freebsd iso image id> --flavor "Standard 1" --availability-zone NL1 --nic net-id=00000000-0000-0000-0000-000000000000 --block-device-mapping hdb=<volume freebsd-10-root id>:::0 FreeBSD-10.0-RELEASE-install
```
* Install the OS to the new disk. Afterwards, stop the instance:
```sh
nova stop <install vm id>
```
* Detach the volume:
```sh
nova volume-detach <install vm id> <install root volume id>
```
* Boot a new instance with the installed OS volume as the root volume:
```sh
nova boot --block-device source=volume,id=<root volume id>,dest=volume,shutdown=preserve,bootindex=0 --flavor "Standard 1" --availability-zone NL1 --nic net-id=00000000-0000-0000-0000-000000000000  FreeBSD-10.0-RELEASE
```
That's it. If you also want to create an image of this install to use for new VM's, continue on.

* Stop the VM with the volume as root disk:
```sh
nova stop <root volume VM id>
```
* Terminate the machine, otherwise you cannot detach the volume (ERROR: Can't detach root device volume (HTTP 403)):
```sh
nova delete <id of root volume VM>
```
* Convert the volume to an image:
```sh
cinder upload-to-image <root volume id> FreeBSD-10.0-RELEASE-cloudinit
```
* This might take a while. Afterwards you can set the image parameters like Min RAM and Cloudinit Support:
```sh
glance image-update --min-disk 8 --min-ram 1024 --property architecture=x86_64 --property image_supports_keypair=true --property image_supports_password=true --property supported=false <id from the converted volume image>
```
Afterwards you can use it as an image for new VM's.
</div>

                            </div>
                        </div>
                    </div>
                    <!-- /.panel -->

                    <div class="panel panel-default">
                        <div class="panel-heading">
                            <h4 class="panel-title">
                                <a class="nocrossref accordion-toggle" data-toggle="collapse" data-parent="#accordion" href="#collapseSixImages">How do I create an image of a server?</a>
                            </h4>
                        </div>
                        <div id="collapseSixImages" class="panel-collapse collapse">
                            <div class="panel-body">
<div markdown="1">
* [Login to the Dashboard][cloud_dashboard_login]
Navigate to the server you want to create an image of
* Click "Create Image"
* Fill in the required parameters
* Click "Create Image"

When creating a new server you can select this image as the base for it.
</div>
                            </div>
                        </div>
                    </div>
                    <!-- /.panel -->

                    <div class="panel panel-default">
                        <div class="panel-heading">
                            <h4 class="panel-title">
                                <a class="nocrossref accordion-toggle" data-toggle="collapse" data-parent="#accordion" href="#collapseSevenImages">How do I download an image?</a>
                            </h4>
                        </div>
                        <div id="collapseSevenImages" class="panel-collapse collapse">
                            <div class="panel-body">
<div markdown="1">
This cannot be done via the dashboard.

Install the Openstack Command line tools and create and source a computerc file.

Use the following command to get a list of images:
```sh
openstack image list
```
Note down the image name or UUID, and use the following command do download the actual image:
```sh
openstack image save --file CentOS7.img --progress "CentOS7"
```
</div>
                            </div>
                        </div>
                    </div>
                    <!-- /.panel -->










</div>
{% include links.html %}
