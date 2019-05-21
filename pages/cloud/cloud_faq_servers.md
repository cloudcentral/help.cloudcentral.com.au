---
title: Cloud Platform Server FAQ
permalink: cloud_faq_servers.html
sidebar: cloud_sidebar
tags: cloud, faq, instance
keywords: frequently asked questions, FAQ, question and answer, collapsible sections, expand, collapse
last_updated: May 20, 2019
summary: "You can use an accordion-layout that takes advantage of Bootstrap styling. This is useful for an FAQ page."
toc: false
folder: cloud
---

<div class="panel-group" id="accordion">
                    <div class="panel panel-default">
                        <div class="panel-heading">
                            <h4 class="panel-title">
                                <a class="noCrossRef accordion-toggle" data-toggle="collapse" data-parent="#accordion" href="#collapseOneServer">What should I do if a resize hangs or fails?</a>
                            </h4>
                        </div>
                        <div id="collapseOneServer" class="panel-collapse collapse noCrossRef">
                            <div class="panel-body">
                            If your server has the status resize_prep or the resize takes longer than 4 hours, please contact our support department via support@cloudvps.nl. Please send the UUID of the server along.
                            </div>
                        </div>
                    </div>
                    <!-- /.panel -->
                    <div class="panel panel-default">
                        <div class="panel-heading">
                            <h4 class="panel-title">
                                <a class="noCrossRef accordion-toggle" data-toggle="collapse" data-parent="#accordion" href="#collapseTwoServer">Through which IP address will my server be communicating if I use a Floating IP address?</a>
                            </h4>
                        </div>
                        <div id="collapseTwoServer" class="panel-collapse collapse noCrossRef">
                            <div class="panel-body">
<div markdown="1"> 
In case you use a Floating IP address, the server will be communicating with the router IP address as its source address. You can verify this by issuing the following command:

```sh
dig +short myip.opendns.com @resolver1.opendns.com
```
or
```sh
curl ifcfg.me
```

The response will show you the IP address from which your server is communicating with.

You however are allowed to set the floating IP as default gateway instead of the router IP. The instance will then use the floating IP as source address.
</div>
                            </div>
                        </div>
                    </div>
                    <!-- /.panel -->

                    <div class="panel panel-default">
                        <div class="panel-heading">
                            <h4 class="panel-title">
                                <a class="noCrossRef accordion-toggle" data-toggle="collapse" data-parent="#accordion" href="#collapseThreeServer">Should I use Security Groups when using an internal network?</a>
                            </h4>
                        </div>
                        <div id="collapseThreeServer" class="panel-collapse collapse noCrossRef">
                            <div class="panel-body">
                            Yes. We advise you to use Security Groups with every type of network or setup.
                            </div>
                        </div>
                    </div>
                    <!-- /.panel -->
 
                    <div class="panel panel-default">
                        <div class="panel-heading">
                            <h4 class="panel-title">
                                <a class="noCrossRef accordion-toggle" data-toggle="collapse" data-parent="#accordion" href="#collapseFourServer">My server has no swap?</a>
                            </h4>
                        </div>
                        <div id="collapseFourServer" class="panel-collapse collapse noCrossRef">
                            <div class="panel-body">
<div markdown="1"> 
Our Supported Images do not come with a swap partition. If you want swap you can add it as a swap file.

First create a swap file, in this example 512 MB (1024 * 512MB = 524288 block size):
```sh
dd if=/dev/zero of=/swap bs=1024 count=524288
```
Execute the following to set up the swap:
```sh
mkswap /swap
```
Set the correct permissions on the file:
```sh
chown root:root /swap
chmod 0600 /swap
```
Activate the swapfile:
```sh
swapon /swap
```
Add it to /etc/fstab to make sure it is loaded at boot:
```sh
vim /etc/fstab:
/swap swap swap defaults 0 0
```
</div>


                            </div>
                        </div>
                    </div>
                    <!-- /.panel -->
 
                    <div class="panel panel-default">
                        <div class="panel-heading">
                            <h4 class="panel-title">
                                <a class="noCrossRef accordion-toggle" data-toggle="collapse" data-parent="#accordion" href="#collapseFiveServer">My server or volumes are in Read Only mode and/or there are IO errors on the console </a>
                            </h4>
                        </div>
                        <div id="collapseFiveServer" class="panel-collapse collapse noCrossRef">
                            <div class="panel-body">
Most Linux distributions remount disks in read-only mode when they find errors on the disk. First try to reboot or power flip your server. If that does not help, check the Skyline dashboard and our @CloudVPSNetwork  twitter account for possible service disruptions.

If there are none, contact our support department via support@cloudvps.nl. Send the UUID of the affected server(s) and volume(s) along.

                            </div>
                        </div>
                    </div>
                    <!-- /.panel -->

 
                    <div class="panel panel-default">
                        <div class="panel-heading">
                            <h4 class="panel-title">
                                <a class="noCrossRef accordion-toggle" data-toggle="collapse" data-parent="#accordion" href="#collapseSixServer">My server does not start up / reboot anymore</a>
                            </h4>
                        </div>
                        <div id="collapseSixServer" class="panel-collapse collapse noCrossRef">
                            <div class="panel-body">
If your server does not reboot or start up, or hangs on the status powering_on or rebooting please first try to power flip your server. If that does not help, check the Skyline dashboard and our @CloudVPSNetwork for possible service disruptions. If there are none, contact our support department via support@cloudvps.nl. Send the UUID of the affected server(s) and volume(s) along.
                            </div>
                        </div>
                    </div>
                    <!-- /.panel -->
 
                    <div class="panel panel-default">
                        <div class="panel-heading">
                            <h4 class="panel-title">
                                <a class="noCrossRef accordion-toggle" data-toggle="collapse" data-parent="#accordion" href="#collapseSevenServer">Is there downtime when I resize a server?</a>
                            </h4>
                        </div>
                        <div id="collapseSevenServer" class="panel-collapse collapse noCrossRef">
                            <div class="panel-body">
                            Yes. The server will reboot to make the resize active.
                            </div>
                        </div>
                    </div>
                    <!-- /.panel -->
 
                    <div class="panel panel-default">
                        <div class="panel-heading">
                            <h4 class="panel-title">
                                <a class="noCrossRef accordion-toggle" data-toggle="collapse" data-parent="#accordion" href="#collapseEightServer">I receive an error while opening the console and it stopped loading.</a>
                            </h4>
                        </div>
                        <div id="collapseEightServer" class="panel-collapse collapse noCrossRef">
                            <div class="panel-body">
                            Please check your internet connection, our regular website and our @CloudVPSNetwork twitter account. Contact support@cloudvps.com if the problem persists. Please include the UUID of the server, which client was used, the date/timestamp of the error and the error itself (if any).
                            </div>
                        </div>
                    </div>
                    <!-- /.panel -->
 
                    <div class="panel panel-default">
                        <div class="panel-heading">
                            <h4 class="panel-title">
                                <a class="noCrossRef accordion-toggle" data-toggle="collapse" data-parent="#accordion" href="#collapseNineServer">I cannot login to the server via ssh and I have not set a root password for console access.</a>
                            </h4>
                        </div>
                        <div id="collapseNineServer" class="panel-collapse collapse noCrossRef">
                            <div class="panel-body">
                            First check the security groups to make sure SSH access is allowed. If that is the case and you still cannot login then you need to reboot the server in Single User mode and reset the root password.


For CentOS, see the official wiki.
For Debian/Ubuntu, see this guide.
                            </div>
                        </div>
                    </div>
                    <!-- /.panel -->
 
                    <div class="panel panel-default">
                        <div class="panel-heading">
                            <h4 class="panel-title">
                                <a class="noCrossRef accordion-toggle" data-toggle="collapse" data-parent="#accordion" href="#collapseTenServer">How do I create an external backup of my Linux Server</a>
                            </h4>
                        </div>
                        <div id="collapseTenServer" class="panel-collapse collapse noCrossRef">
                            <div class="panel-body">
                            We provide a special script to backup Linux servers to the Objectstore and can be found here: https://www.cloudvps.com/helpcenter/knowledgebase/backup-snapshots/cloudvps-boss-linux-backup-object-store
                            </div>
                        </div>
                    </div>
                    <!-- /.panel -->

 
                    <div class="panel panel-default">
                        <div class="panel-heading">
                            <h4 class="panel-title">
                                <a class="noCrossRef accordion-toggle" data-toggle="collapse" data-parent="#accordion" href="#collapseElevenServer">How do I create a snapshot of a server/volume?</a>
                            </h4>
                        </div>
                        <div id="collapseElevenServer" class="panel-collapse collapse noCrossRef">
                            <div class="panel-body">
<div markdown="1"> 
Server

For servers we don't support snapshots from Skyline. You can however create an image of it:



Log in to Skyline
Navigate to the server you want to snapshot
Click "Create Image"

We do support the nova backup option. These backups will show up as Images in Skyline.


Make sure you have the Openstack Command Line tools installed and have a computerc file sourced. Execute the following example command:

nova backup UUID backup-name daily 7

This will create an image named "backup-name", it will be a daily image and it will be kept 7 days. See the Official documentation for more info
To restore either backup types, create a new image from that image.



Volumes




Log in to Skyline
Navigate to the volume you want to snapshot
Click "Create Snapshot"
</div>
                            </div>
                        </div>
                    </div>
                    <!-- /.panel -->

 
                    <div class="panel panel-default">
                        <div class="panel-heading">
                            <h4 class="panel-title">
                                <a class="noCrossRef accordion-toggle" data-toggle="collapse" data-parent="#accordion" href="#collapseTwelveServer">How can I convert a public fixed IP address to a Floating IP address?</a>
                            </h4>
                        </div>
                        <div id="collapseTwelveServer" class="panel-collapse collapse noCrossRef">
                            <div class="panel-body">
                            It is not possible to convert public fixed IP address to a Floating IP address.
                            </div>
                        </div>
                    </div>
                    <!-- /.panel -->

 
                    <div class="panel panel-default">
                        <div class="panel-heading">
                            <h4 class="panel-title">
                                <a class="noCrossRef accordion-toggle" data-toggle="collapse" data-parent="#accordion" href="#collapseThirteenServer">How do I clone a server?</a>
                            </h4>
                        </div>
                        <div id="collapseThirteenServer" class="panel-collapse collapse noCrossRef">
                            <div class="panel-body">
<div markdown="1"> 
Login to Skyline
Navigate to the server you want to clone
Click "Create Image"
Wait for the image creation to finish
Create a new server based of this image via the "New Server" button
</div>
                            </div>
                        </div>
                    </div>
                    <!-- /.panel -->

 
                    <div class="panel panel-default">
                        <div class="panel-heading">
                            <h4 class="panel-title">
                                <a class="noCrossRef accordion-toggle" data-toggle="collapse" data-parent="#accordion" href="#collapseFourteenServer">Can I use the ObjectStore to store by Linux backups?</a>
                            </h4>
                        </div>
                        <div id="collapseFourteenServer" class="panel-collapse collapse noCrossRef">
                            <div class="panel-body">
                            Yes. We provide a special script to backup Linux servers to the Objectstore and can be found here: https://www.cloudvps.com/helpcenter/knowledgebase/backup-snapshots/cloudvps-boss-linux-backup-object-store
                            </div>
                        </div>
                    </div>
                    <!-- /.panel -->

 
                    <div class="panel panel-default">
                        <div class="panel-heading">
                            <h4 class="panel-title">
                                <a class="noCrossRef accordion-toggle" data-toggle="collapse" data-parent="#accordion" href="#collapseFifteenServer">Can I boot up an i368 image?</a>
                            </h4>
                        </div>
                        <div id="collapseFifteenServer" class="panel-collapse collapse noCrossRef">
                            <div class="panel-body">
                            Yes. We only support 64 bit Operating Systems and Images, so you should set the type of the image/server to x86_64 in Skyline. Since x86_64 is backwards compatible you can run x86 software.
                            </div>
                        </div>
                    </div>
                    <!-- /.panel -->
 
                    <div class="panel panel-default">
                        <div class="panel-heading">
                            <h4 class="panel-title">
                                <a class="noCrossRef accordion-toggle" data-toggle="collapse" data-parent="#accordion" href="#collapseSixteenServer">Can I downsize/downgrade a server?</a>
                            </h4>
                        </div>
                        <div id="collapseSixteenServer" class="panel-collapse collapse noCrossRef">
                            <div class="panel-body">
                            No, this is not possible. If you have a small server and want more RAM or more cores, resize up to a Small HD Flavour. Small HD Flavours can be up and downsized because the disk size is the same. Flavours above Standard 3 cannot be downsized.
                            </div>
                        </div>
                    </div>
                    <!-- /.panel -->


 
                    <div class="panel panel-default">
                        <div class="panel-heading">
                            <h4 class="panel-title">
                                <a class="noCrossRef accordion-toggle" data-toggle="collapse" data-parent="#accordion" href="#collapseSeventeenServer">Can I upsize/upgrade a server?</a>
                            </h4>
                        </div>
                        <div id="collapseSeventeenServer" class="panel-collapse collapse noCrossRef">
                            <div class="panel-body">
                            Yes. Via Skyline you can select the server and the click the Resize button. See the above item on downsizing/downgrading if you, in the future, want to downgrade your instance. Your server will reboot during a resize.
                            </div>
                        </div>
                    </div>
                    <!-- /.panel -->

 
                    <div class="panel panel-default">
                        <div class="panel-heading">
                            <h4 class="panel-title">
                                <a class="noCrossRef accordion-toggle" data-toggle="collapse" data-parent="#accordion" href="#collapseEighteenServer">Can I run a desktop environment like KDE or Gnome?</a>
                            </h4>
                        </div>
                        <div id="collapseEighteenServer" class="panel-collapse collapse noCrossRef">
                            <div class="panel-body">
                            Yes. You can install the required packages (apt-get install ubuntu-desktop) and run a regular desktop. Do note that this will consume more resources and might require a more powerful instance.
                            </div>
                        </div>
                    </div>
                    <!-- /.panel -->





</div>

{% include links.html %}
