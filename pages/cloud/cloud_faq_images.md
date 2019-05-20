---
title: Cloud Platform Images FAQ
permalink: cloud_faq_images.html
sidebar: cloud_sidebar
tags: cloud, faq
keywords: frequently asked questions, FAQ, question and answer, collapsible sections, expand, collapse
last_updated: November 30, 2015
summary: "You can use an accordion-layout that takes advantage of Bootstrap styling. This is useful for an FAQ page."
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
                            If your servers spawned from your own image don't resize or keep the status resize_prep then they do not shutdown correctly and don't respond to ACPI requests Openstack sends.

First shut down the VM and then retry the resize.

Make sure that the following kernel module is loaded:

acpiphp

This is the kernel module that handles the shutdown requests and such.
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
                            Make sure your image has VirtIO Disk and NIC support. We don't support any other formats like IDE, SATA or e1000.
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
                            Login to Skyline
Navigate to: Images
Click "Upload Image"
Enter the required parameters:
Image Name
Type (QCOW2, RAW, VHD, VMDK, VDI, ISO9660)
Cloud Init support (Does this image allow openstack to set the password and ssh key via cloud-init?)
Minimum Disk
Minimum RAM
Image file
Click "Upload Image"
Wait for the upload to finish.
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
                            The image you create should have support for cloud-init.

This is the program that changes the user password, ssh key and makes sure resizes work better.

When you are installing the image, make sure it is installed along.

Follow the steps in their documentation to configure it: http://cloudinit.readthedocs.org/en/latest/
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

                            First make sure you have an ISO present to upload, for example, FreeBSD:
                            <pre>
wget http://ftp.freebsd.org/pub/FreeBSD/releases/amd64/amd64/ISO-IMAGES/10.0/FreeBSD-10.0-RELEASE-amd64-disc1.iso

Make sure then OS has VirtIO disk and VirtIO NIC support.

Upload it to Openstack:

glance image-create --file FreeBSD-10.0-RELEASE-amd64-disc1.iso --name "FreeBSD-10.0-RELEASE-amd64-disc1.iso" --disk-format iso --container-format bare --progress

Create the root volume:

cinder create --display-name "freebsd-10-root" 8

Now boot a new instance with the ISO and the newly created root volume:

nova boot --image &lt;freebsd iso image id&gt; --flavor "Standard 1" --availability-zone NL1 --nic net-id=00000000-0000-0000-0000-000000000000 --block-device-mapping hdb=&lt;volume freebsd-10-root id&gt;:::0 FreeBSD-10.0-RELEASE-install

Install the OS to the new disk. Afterwards, stop the instance:

nova stop &lt;install vm id&gt;

Detach the volume:

nova volume-detach &lt;install vm id&gt; &lt;install root volume id&gt;

Boot a new instance with the installed OS volume as the root volume:

nova boot --block-device source=volume,id=&lt;root volume id&gt;,dest=volume,shutdown=preserve,bootindex=0 --flavor "Standard 1" --availability-zone NL1 --nic net-id=00000000-0000-0000-0000-000000000000  FreeBSD-10.0-RELEASE

That's it. If you also want to create an image of this install to use for new VM's, continue on.

Stop the VM with the volume as root disk:

nova stop &lt;root volume VM id&gt;

Terminate the machine, otherwise you cannot detach the volume (ERROR: Can't detach root device volume (HTTP 403)):

nova delete &lt;id of root volume VM&gt;

Convert the volume to an image:

cinder upload-to-image &lt;root volume id&gt; FreeBSD-10.0-RELEASE-cloudinit

This might take a while. Afterwards you can set the image parameters like Min RAM and Cloudinit Support:

glance image-update --min-disk 8 --min-ram 1024 --property architecture=x86_64 --property image_supports_keypair=true --property image_supports_password=true --property supported=false &lt;id from the converted volume image&gt;
                            </pre>
Afterwards you can use it as an image for new VM's.

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
                            Login to Skyline
Navigate to the server you want to create an image of
Click "Create Image"
Fill in the required parameters
Click "Create Image"

When creating a new server you can select this image as the base for it.
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
                            This cannot be done via Skyline.


Install the Openstack Command line tools and create and source a computerc file.


Use the following command to get a list of images:

glance image-list

Note down the image name or UUID, and use the following command do download the actual image:

glance image-download --file CloudVPS-Ubuntu-14.04.img --progress "CloudVPS Ubuntu 14.04"

The syntax is:

glance image-download --file LOCAL_FILENAME --progress "IMAGE UUID/NAME"
                            </div>
                        </div>
                    </div>
                    <!-- /.panel -->










</div>
{% include links.html %}
