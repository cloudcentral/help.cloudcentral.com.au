---
title: Cloud Platform General FAQ
permalink: cloud_faq_general.html
sidebar: cloud_sidebar
tags: cloud, faq
keywords: frequently asked questions, FAQ, question and answer, collapsible sections, expand, collapse
last_updated: May 20, 2019
summary: "Frequently asked questions regarding the Cloud Platform"
toc: false
folder: cloud
---

<div class="panel-group" id="accordion">
                    <div class="panel panel-default">
                        <div class="panel-heading">
                            <h4 class="panel-title">
                                <a class="noCrossRef accordion-toggle" data-toggle="collapse" data-parent="#accordion" href="#collapseOneGeneral">Where can I find the health status of the platform or view platform status reports?</a>
                            </h4>
                        </div>
                        <div id="collapseOneGeneral" class="panel-collapse collapse noCrossRef">
                            <div class="panel-body">
<div markdown="1">
For more information regarding the status about our network and services we have a special CloudCentral status page.

With the use of statuspage you have a full insight regarding all our platforms

You can find the status pages at the following link [Service Status](https://status.cloudcentral.com.au)

Platforms you can subscribe for:

* Network
* API
* Dashboard

Next to this you can subscribe for notications by email using [Service Status](https://status.cloudcentral.com.au)

When our network or services status changes you will be notified by email.
</div>
                            </div>
                        </div>
                    </div>
                    <!-- /.panel -->
                    <div class="panel panel-default">
                        <div class="panel-heading">
                            <h4 class="panel-title">
                                <a class="noCrossRef accordion-toggle" data-toggle="collapse" data-parent="#accordion" href="#collapseTwoGeneral">Where can I find the official OpenStack API documentation?</a>
                            </h4>
                        </div>
                        <div id="collapseTwoGeneral" class="panel-collapse collapse noCrossRef">
                            <div class="panel-body">
<div markdown="1">
You can find all developer related documentation including the API documentation on the OpenStack official developer page: [http://developer.openstack.org](http://developer.openstack.org)
</div>
                            </div>
                        </div>
                    </div>
                    <!-- /.panel -->
                    <div class="panel panel-default">
                        <div class="panel-heading">
                            <h4 class="panel-title">
                                <a class="noCrossRef accordion-toggle" data-toggle="collapse" data-parent="#accordion" href="#collapseThreeGeneral">What are the default quotas?</a>
                            </h4>
                        </div>
                        <div id="collapseThreeGeneral" class="panel-collapse collapse noCrossRef">
                            <div class="panel-body">
<div markdown="1">
The default Cloud Platform quotas are:

* Max servers: 8
* Maximum CPU Cores: 16
* Maximum RAM: 16GB
* Maximum volumes: 8
* Maximum Volume Space: 1T
* Maximum floating IPs: 50
* Maximum number of networks: 100
* Maximum number of routers: 10
* Maximum number of images: 20
* Maximum number of snapshots: 16

If you want your quota raised, please contact our [Support department](https://connect.cloudcentral.com.au)
</div>
{% include note.html content="Test accounts have lower quotas." %}
                            </div>
                        </div>
                    </div>
                    <!-- /.panel -->
                    <div class="panel panel-default">
                        <div class="panel-heading">
                            <h4 class="panel-title">
                                <a class="noCrossRef accordion-toggle" data-toggle="collapse" data-parent="#accordion" href="#collapseFourGeneral">Where can I monitor the amount of traffic for each OpenStack server?</a>
                            </h4>
                        </div>
                        <div id="collapseFourGeneral" class="panel-collapse collapse">
                            <div class="panel-body">
                            At this moment we do not provide traffic statistics for OpenStack servers.
                            </div>
                        </div>
                    </div>
                    <!-- /.panel -->
                    <div class="panel panel-default">
                        <div class="panel-heading">
                            <h4 class="panel-title">
                                <a class="noCrossRef accordion-toggle" data-toggle="collapse" data-parent="#accordion" href="#collapseFiveGeneral">What version of Openstack (Nova/Swift/etc) do you run?</a>
                            </h4>
                        </div>
                        <div id="collapseFiveGeneral" class="panel-collapse collapse">
                            <div class="panel-body">
                            All Openstack components are running Rocky.
                            </div>
                        </div>
                    </div>
                    <!-- /.panel -->

                    <div class="panel panel-default">
                        <div class="panel-heading">
                            <h4 class="panel-title">
                                <a class="noCrossRef accordion-toggle" data-toggle="collapse" data-parent="#accordion" href="#collapseSixGeneral">I am missing a feature, how can I submit a feature request?</a>
                            </h4>
                        </div>
                        <div id="collapseSixGeneral" class="panel-collapse collapse">
                            <div class="panel-body">
<div markdown="1">
Please send us all your feedback and feature requests to our [Support department](https://connect.cloudcentral.com.au).
</div>
                            </div>
                        </div>
                    </div>
                    <!-- /.panel -->

                    <div class="panel panel-default">
                        <div class="panel-heading">
                            <h4 class="panel-title">
                                <a class="nocrossref accordion-toggle" data-toggle="collapse" data-parent="#accordion" href="#collapseSevenGeneral">How do i install the openstack command line clients?</a>
                            </h4>
                        </div>
                        <div id="collapseSevenGeneral" class="panel-collapse collapse">
                            <div class="panel-body">
<div markdown="1">
Please see the following [guide][cloud_cli_install]
</div>
                            </div>
                        </div>
                    </div>
                    <!-- /.panel -->

                    <div class="panel panel-default">
                        <div class="panel-heading">
                            <h4 class="panel-title">
                                <a class="nocrossref accordion-toggle" data-toggle="collapse" data-parent="#accordion" href="#collapseEightGeneral">Do you offer VPN as a Service?</a>
                            </h4>
                        </div>
                        <div id="collapseEightGeneral" class="panel-collapse collapse">
                            <div class="panel-body">
<div markdown="1">
Yes, see [here][cloud_dashboard_vpns]
</div>
                            </div>
                        </div>
                    </div>
                    <!-- /.panel -->

                    <div class="panel panel-default">
                        <div class="panel-heading">
                            <h4 class="panel-title">
                                <a class="nocrossref accordion-toggle" data-toggle="collapse" data-parent="#accordion" href="#collapseNineGeneral">Can I have multiple projects?</a>
                            </h4>
                        </div>
                        <div id="collapseNineGeneral" class="panel-collapse collapse">
                            <div class="panel-body">
<div markdown="1">
Yes, by default you are allowed to have 3 projects.

You can create users and projects in the [Dashboard](https://console.cloudcentral.com.au).

Please contact our [Support department](https://connect.cloudcentral.com.au) if you would like to increase this limit.
</div>
                            </div>
                        </div>
                    </div>
                    <!-- /.panel -->

                    <div class="panel panel-default">
                        <div class="panel-heading">
                            <h4 class="panel-title">
                                <a class="nocrossref accordion-toggle" data-toggle="collapse" data-parent="#accordion" href="#collapseTenGeneral">Can I shelve a server?</a>
                            </h4>
                        </div>
                        <div id="collapseTenGeneral" class="panel-collapse collapse">
                            <div class="panel-body">
<div markdown="1">
With the API you can shelve a server:
```sh
openstack server stop $VM_UUID
openstack server shelve $VM_UUID
```
To unshelve:
```sh
openstack server unshelve $VM_UUID
openstack server $VM_UUID
```
{% include note.html content="Do note that you need to shut down a server before shelving it, otherwise you get an error. If you try to boot a shelved server, you will also get an error, the server needs to be unshelved first." %}
</div>
                            </div>
                        </div>
                    </div>
                    <!-- /.panel -->

                    <div class="panel panel-default">
                        <div class="panel-heading">
                            <h4 class="panel-title">
                                <a class="nocrossref accordion-toggle" data-toggle="collapse" data-parent="#accordion" href="#collapseElevenGeneral">Can I change my project quota?</a>
                            </h4>
                        </div>
                        <div id="collapseElevenGeneral" class="panel-collapse collapse">
                            <div class="panel-body">
<div markdown="1">
Yes.

You can contact our [Support department](https://connect.cloudcentral.com.au) to either raise or lower your quota per project.
</div>
                            </div>
                        </div>
                    </div>
                    <!-- /.panel -->

                    <div class="panel panel-default">
                        <div class="panel-heading">
                            <h4 class="panel-title">
                                <a class="nocrossref accordion-toggle" data-toggle="collapse" data-parent="#accordion" href="#collapseTwelveGeneral">Can I create my own flavors?</a>
                            </h4>
                        </div>
                        <div id="collapseTwelveGeneral" class="panel-collapse collapse">
                            <div class="panel-body">
<div markdown="1">
No, this is not possible.

You can resize your instance to a bigger flavour but you cannot change a flavor or make your own flavor.
</div>
                            </div>
                        </div>
                    </div>
                    <!-- /.panel -->

                    <div class="panel panel-default">
                        <div class="panel-heading">
                            <h4 class="panel-title">
                                <a class="nocrossref accordion-toggle" data-toggle="collapse" data-parent="#accordion" href="#collapseThirteenGeneral">Do you have an OpenStack Control Panel?</a>
                            </h4>
                        </div>
                        <div id="collapseThirteenGeneral" class="panel-collapse collapse">
                            <div class="panel-body">
<div markdown="1">
Yes, please access the [Dashboard](https://console.cloudcentral.com.au)
</div>
                            </div>
                        </div>
                    </div>
                    <!-- /.panel -->

</div>
{% include links.html %}
