---
title: Cloud Platform Security Group FAQ
permalink: cloud_faq_securitygroups.html
sidebar: cloud_sidebar
tags: cloud, faq, network
keywords: frequently asked questions, FAQ, question and answer, collapsible sections, expand, collapse
last_updated: May 20, 2019
summary: "Frequently asked questions regarding the Cloud Platform Security Groups"
toc: false
folder: cloud
---

<div class="panel-group" id="accordion">
                    <div class="panel panel-default">
                        <div class="panel-heading">
                            <h4 class="panel-title">
                                <a class="noCrossRef accordion-toggle" data-toggle="collapse" data-parent="#accordion" href="#collapseOneSecuritygroup">Why does all the built-in security groups have no restrictions on all outbound traffic?</a>
                            </h4>
                        </div>
                        <div id="collapseOneSecuritygroup" class="panel-collapse collapse noCrossRef">
                            <div class="panel-body">
<div markdown="1">
We have configured the built-in security groups to have no restriction on all outbound traffic to simplify the setup.

Custom Security Groups can be create and applied blocking outbound access if required.
</div>
                            </div>
                        </div>
                    </div>
                    <!-- /.panel -->
                    <div class="panel panel-default">
                        <div class="panel-heading">
                            <h4 class="panel-title">
                                <a class="noCrossRef accordion-toggle" data-toggle="collapse" data-parent="#accordion" href="#collapseTwoSecuritygroup">Will the inbound rules be added to my quota?</a>
                            </h4>
                        </div>
                        <div id="collapseTwoSecuritygroup" class="panel-collapse collapse noCrossRef">
                            <div class="panel-body">
<div markdown="1">
Yes, all Security Group rules will be counted to your quota (default 20).
</div>
                            </div>
                        </div>
                    </div>
                    <!-- /.panel -->
                    <div class="panel panel-default">
                        <div class="panel-heading">
                            <h4 class="panel-title">
                                <a class="noCrossRef accordion-toggle" data-toggle="collapse" data-parent="#accordion" href="#collapseThreeSecuritygroup">Does Security Groups behave as least restrictive or most restrictive?</a>
                            </h4>
                        </div>
                        <div id="collapseThreeSecuritygroup" class="panel-collapse collapse noCrossRef">
                            <div class="panel-body">
<div markdown="1">
Security Groups behave as least restrictive.

This means that if you have configured Security Groups with conflicting rules the Security Group with the least restrictive rule will be active. (ALLOW over BLOCK).
</div>
                            </div>
                        </div>
                    </div>
                    <!-- /.panel -->
                    <div class="panel panel-default">
                        <div class="panel-heading">
                            <h4 class="panel-title">
                                <a class="noCrossRef accordion-toggle" data-toggle="collapse" data-parent="#accordion" href="#collapseFourSecuritygroup">Can I change the name or description of an Security Group?</a>
                            </h4>
                        </div>
                        <div id="collapseFourSecuritygroup" class="panel-collapse collapse noCrossRef">
                            <div class="panel-body">
<div markdown="1">
Yes.

This can be done through the API with the command:
```sh
nova secgroup-upate <UUID> "<name>" "<description>"
```
</div>
                            </div>
                        </div>
                    </div>
                    <!-- /.panel -->
</div>

{% include links.html %}
