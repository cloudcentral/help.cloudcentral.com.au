---
title: Cloud Platform Volume FAQ
permalink: cloud_faq_volumes.html
sidebar: cloud_sidebar
tags: cloud, faq, volume
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
                                <a class="noCrossRef accordion-toggle" data-toggle="collapse" data-parent="#accordion" href="#collapseOneVolume">My volume has status error, could you reset it?</a>
                            </h4>
                        </div>
                        <div id="collapseOneVolume" class="panel-collapse collapse noCrossRef">
                            <div class="panel-body">
                            Yes. Please contact support@cloudvs.com with the UUID of the volume and the state you would like it to be reset to (available if not attached or in-use if attached) and we will reset it to your desired state.
                            </div>
                        </div>
                    </div>
                    <!-- /.panel -->
                    <div class="panel panel-default">
                        <div class="panel-heading">
                            <h4 class="panel-title">
                                <a class="noCrossRef accordion-toggle" data-toggle="collapse" data-parent="#accordion" href="#collapseTwoVolume">I noticed my volume is mounted read-only, how come?</a>
                            </h4>
                        </div>
                        <div id="collapseTwoVolume" class="panel-collapse collapse noCrossRef">
                            <div class="panel-body">
                            In case of an outage the volume might become read-only to save your data. Please reboot your server to let it remount correctly again.
                            </div>
                        </div>
                    </div>
                    <!-- /.panel -->
                    <div class="panel panel-default">
                        <div class="panel-heading">
                            <h4 class="panel-title">
                                <a class="noCrossRef accordion-toggle" data-toggle="collapse" data-parent="#accordion" href="#collapseThreeVolume">I am unable to create a new volume (stuck in status creating)</a>
                            </h4>
                        </div>
                        <div id="collapseThreeVolume" class="panel-collapse collapse noCrossRef">
                            <div class="panel-body">
                            Please contact support@cloudvps.com with the UUID of the stuck volume and we will look into it. Please include which client was used, the date/timestamp of the error and the error itself (if any).
                            </div>
                        </div>
                    </div>
                    <!-- /.panel -->
                    <div class="panel panel-default">
                        <div class="panel-heading">
                            <h4 class="panel-title">
                                <a class="noCrossRef accordion-toggle" data-toggle="collapse" data-parent="#accordion" href="#collapseFourVolume">Can I schedule automatic snapshotting of servers?</a>
                            </h4>
                        </div>
                        <div id="collapseFourVolume" class="panel-collapse collapse noCrossRef">
                            <div class="panel-body">
                            While we do not provide an out-of-the box solution, you can however set up a cronjob which communicates with the OpenStack API to automatically take snapshots.
                            </div>
                        </div>
                    </div>
                    <!-- /.panel -->
                    <div class="panel panel-default">
                        <div class="panel-heading">
                            <h4 class="panel-title">
                                <a class="noCrossRef accordion-toggle" data-toggle="collapse" data-parent="#accordion" href="#collapseFiveVolume">How do I safely wipe a volume?</a>
                            </h4>
                        </div>
                        <div id="collapseFiveVolume" class="panel-collapse collapse noCrossRef">
                            <div class="panel-body">
<div markdown="1"> 
Just as when throwing away a physical computer, it is a good practice to shred all data on a virtual hard disk, when a virtual machine is deleted or a volume is removed. Overwriting all space with specialized software so that data cannot be read or retreived when the space later provisioned to another user.

The responsibility of the correct and complete wipe of data is with the end user. Because of our IaaS service, we don't know what our customers do with the resources they pay for, what data they save or process and therefore we cannot do any assumptions on the security measurements required to accurately wipe the disk.

On a Linux system you can safely wipe a disk by using the 'shred' program. This software is part of the GNU coreutils package and thus is installed on every Linux image we provide. The software is made to wipe data in files, folders and devices (such as volumes) in a way that makes sure it is not readable by others after wiping. If the default settings are used an item (folder, file, device) will be overwritten three times with random data.

On our OpenStack platform you can use the below command to wipe a volume on a linux system:
```sh
shred --verbose /dev/vdb
```
This command is executed as root, where vdb is the disk on which the volume is attached to the instance. To see all attached disks, use the lsblk command:
```sh
# lsblk
NAME MAJ:MIN RM SIZE RO TYPE MOUNTPOINT
sr0 11:0 1 410K 0 rom
vda 253:0 0 128G 0 disk
|-vda1 253:1 0 237M 0 part /boot
`-vda2 253:2 0 127.8G 0 part /
vdb 253:16 0 8G 0 disk
The output of the shred command, example:

shred: /dev/vdb: pass 1/3 (random)...
shred: /dev/vdb: pass 1/3 (random)...4.4GiB/8.0GiB 55%
shred: /dev/vdb: pass 1/3 (random)...8.0GiB/8.0GiB 100%
shred: /dev/vdb: pass 2/3 (random)...
shred: /dev/vdb: pass 2/3 (random)...4.2GiB/8.0GiB 53%
shred: /dev/vdb: pass 2/3 (random)...5.7GiB/8.0GiB 71%
shred: /dev/vdb: pass 2/3 (random)...8.0GiB/8.0GiB 100%
shred: /dev/vdb: pass 3/3 (random)...
shred: /dev/vdb: pass 3/3 (random)...4.1GiB/8.0GiB 51%
shred: /dev/vdb: pass 3/3 (random)...8.0GiB/8.0GiB 100%
```
In some cases volumes are using the virtio-scsi driver instead of virtio, you must use /dev/sdb then. This has no effect  on the wipe itself.

It's important to keep in mind that there is no confirmation of the shred command. If you provide the wrong path, you might wipe the wrong data. This cannot be recovered.

In the official documentation of 'shred' you can read more on how the software works and other command line parameters: https://www.gnu.org/software/coreutils/manual/html_node/shred-invocation

On Windows you can use 'sdelete'. See the official Microsoft documentation for usage instructions: https://docs.microsoft.com/en-us/sysinternals/downloads/sdelete.

If you need a graphical interface on Windows you can for example use: http://www.killdisk.com/eraser.htm or https://eraser.heidi.ie/.

If you have any questions, please contact our support via support@cloudvps.nl.
</div>

                            </div>
                        </div>
                    </div>
                    <!-- /.panel -->
</div>

{% include links.html %}
