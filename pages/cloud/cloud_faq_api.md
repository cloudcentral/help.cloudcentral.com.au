---
title: Cloud Platform API FAQ
permalink: cloud_faq_api.html
sidebar: cloud_sidebar
tags: cloud, faq
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
                                <a class="noCrossRef accordion-toggle" data-toggle="collapse" data-parent="#accordion" href="#collapseOneApi">Where can I find my API credentials?</a>
                            </h4>
                        </div>
                        <div id="collapseOneApi" class="panel-collapse collapse noCrossRef">
                            <div class="panel-body">
<div markdown="1">
Your API credentials contains the follow details:
* Auth URL
* Tenant ID
* Tenant Name
* Username
* Password
You can find all those details in the OpenStack product delivery email received after ordering the OpenStack product.You can also find all credentials except the password in Skyline, log in and click the Cog icon, then click Authorization Info.

If you are unable to retrieve these details please contact the [Support department](https://connect.cloudcentral.com.au) so we can reset your account details.
</div>
                            </div>
                        </div>
                    </div>
                    <!-- /.panel -->
                    <div class="panel panel-default">
                        <div class="panel-heading">
                            <h4 class="panel-title">
                                <a class="noCrossRef accordion-toggle" data-toggle="collapse" data-parent="#accordion" href="#collapseTwoApi">Where can I find the official OpenStack API documentation?</a>
                            </h4>
                        </div>
                        <div id="collapseTwoApi" class="panel-collapse collapse noCrossRef">
                            <div class="panel-body">
<div markdown="1">
You can find all developer related documentation including the API documentation on the OpenStack official developer page: [https://developer.openstack.org](https://developer.openstack.org)
</div>
                            </div>
                        </div>
                    </div>
                    <!-- /.panel -->
                    <div class="panel panel-default">
                        <div class="panel-heading">
                            <h4 class="panel-title">
                                <a class="noCrossRef accordion-toggle" data-toggle="collapse" data-parent="#accordion" href="#collapseThreeApi">The API response seems slow</a>
                            </h4>
                        </div>
                        <div id="collapseThreeApi" class="panel-collapse collapse noCrossRef">
                            <div class="panel-body">
<div markdown="1">
In case of high volume API request, the requests might take longer to process leading to a slower response of the API. We advise you to contact the [Support department](https://connect.cloudcentral.com.au) if the problem persists. Please include which client was used, the date/timestamp of the error and the error itself.
</div>
                            </div>
                        </div>
                    </div>
                    <!-- /.panel -->
                    <div class="panel panel-default">
                        <div class="panel-heading">
                            <h4 class="panel-title">
                                <a class="noCrossRef accordion-toggle" data-toggle="collapse" data-parent="#accordion" href="#collapseFourApi">I receive 502/503 errors</a>
                            </h4>
                        </div>
                        <div id="collapseFourApi" class="panel-collapse collapse">
                            <div class="panel-body">
<div markdown="1">
If you receive 50x errors, please retry to submit the request.  If the problem persists, please contact the [Support department](https://connect.cloudcentral.com.au) with the request and response message. Please include which client was used, the date/timestamp of the error and the error itself.
</div>
                            </div>
                        </div>
                    </div>
                    <!-- /.panel -->
</div>
<!-- /.panel-group -->

{% include links.html %}
