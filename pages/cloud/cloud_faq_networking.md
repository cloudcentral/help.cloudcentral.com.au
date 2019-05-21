---
title: Cloud Platform Networking FAQ
permalink: cloud_faq_networking.html
sidebar: cloud_sidebar
tags: cloud, faq, network
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
                                <a class="noCrossRef accordion-toggle" data-toggle="collapse" data-parent="#accordion" href="#collapseOneNetwork">How to configure multiple floating IP's?</a>
                            </h4>
                        </div>
                        <div id="collapseOneNetwork" class="panel-collapse collapse noCrossRef">
                            <div class="panel-body">
<div markdown="1">

It is possible to attach multiple floating IP's to a single instance. To configure multiple floating IP's some configuration settings are required to adjust to your setup. This manual describes how to configure and setup your instance and network in detail with an additional video instruction.

Some basic knowledge and understanding about networks are required.

First login the Horizon interface the create a private subnet to use for attaching the floating IP's.

* Login to the Horizon interface
* Select "Network" and then "Networking" from the left menu pane.
* Select "+CREATE NETWORK"
* Create a new name for the network
* Select subnet and fill in a new "Subnet Name"
* Fill in a new subnet range, in this example we use the ip range 192.168.1.0/24
* Nothing more is needed to configure, select "create"
* Create a new router as default gateway for the new subnet.

* Select "Network" and then "Routers" from the left menu pane.
* Select "+CREATE ROUTER"
* Fill in a new router name
* Select "Create Router"
* Select "Set Gateway" for the created router
* At "External Network" select the network "Floating" 
* Select "SET GATEWAY" 
* Select the new created router from the overview
* Select "+ADD INTERFACE" 
* At the subnet section select "ADD INTERFACE" from the new subnet created before

Create an instance and attach multiple interfaces.

* Select "Compute" and then "Instances" from the left menu pane.
* Create a new instance Ubuntu or CentOS and make sure the first interface attached is the newly created subnet
* Select "Attach Interface" from the pull-down menu from the created instance and select "Attach Interface" 
* Select the created subnet
* Repeat this step 3 times and make sure all interfaces are attached to the same subnet
* Attach a floating IP to a network interface 

* Select "Network" and then "Floating IPs" from the left menu pane.
* Select "ALLOCATE IP TO PROJECT" and then "ALLOCATE IP"
* At the main screen select "ASSOCIATE" from the allocated floating IP.
* Select the correct interface from "Port to be associated" and select "ASSOCIATE" 
* Repeat these steps until a floating IP is attached to all interfaces.
 


 

After creating a new instance in the Horizon interface, you need to setup IP routing on the instance itself to make sure all floating IPs are available from the outside network. Because every interface is configured at the same subnet and with the same default gateway, we need to create a routing entry for every interface. Below described how to configure for Ubuntu and CentOS.

## Updating the routing table for Ubuntu and CentOS
First adjust the routing table to make sure a table entry is made for every interface.

Open the routing table with a editor.
```sh
vim /etc/iproute2/rt_tables
```
In this example we make table entries for 3 network interfaces, table1, table2 and table3. Setup a priority for every entry like in the example below.
```sh
#
# reserved values
#
255    local
254    main
253    default
0    unspec
#
# local
#
#1    inr.ruhep

# Floating IPs
100    table1 
101    table2
102    table3 
```
## Enable IP Forwarding 

Check if IP forwarding is enabled 
```sh
sysctl net.ipv4.ip_forward
```
Output value need to be 1 , if 0 the IP forwarding configuration is needed

net.ipv4.ip_forward = 1
Enable IP forwarding, open the sysctl configuration with a editor
```sh
vim /etc/sysctl.conf
```
Add or adjust the line below to the sysctl configuration 
```
net.ipv4.ip_forward = 1
```
Reload sysctl the activate the new settings 
```sh
sysctl --system
```

## Configure network configuration for Ubuntu
Open the network interface configuration file with a editor 
```sh
vim /etc/network/interfaces
```
The example below shows how to setup all 3 network interfaces. Every network interface retrieves ip information with DHCP and static routing is setup manually. Adjust IP information to your own situation.

```
# The First network interface: Floating IP 1.2.3.4
auto     eth0
iface    eth0        inet dhcp 

post-up      ip route add 192.168.1.0/24 dev eth0 src 192.168.1.3 table table1 
post-up      ip route add default via 192.168.1.1 dev eth0 table table1    
post-up      ip rule add from 192.168.1.3/32 table table1    
post-up      ip rule add to 192.168.1.3/32 table table1 
post-down    ip route del 192.168.1.0/24 dev eth0 src 192.168.1.3 table table1
post-down    ip route del default via 192.168.1.1 dev eth0 table table1
post-down    ip rule del from 192.168.1.3/32 table table1
post-down    ip rule del to 192.168.1.3/32 table table1

# The Second network interface: Floating IP 1.2.3.4
auto     eth1
iface    eth1        inet dhcp 

post-up      ip route add 192.168.1.0/24 dev eth1 src 192.168.1.4 table table2
post-up      ip route add default via 192.168.1.1 dev eth1 table table2
post-up      ip rule add from 192.168.1.4/32 table table2  
post-up      ip rule add to 192.168.1.4/32 table table2 
post-down    ip route del 192.168.1.0/24 dev eth1 src 192.168.1.4 table table2
post-down    ip route del default via 192.168.1.1 dev eth1 table table2
post-down    ip rule del from 192.168.1.4/32 table table2 
post-down    ip rule del to 192.168.1.4/32 table table2

# The Thirth network interface:    Floating IP 1.2.3.4
auto     eth2
iface    eth2        inet dhcp 

post-up      ip route add 192.168.1.0/24 dev bridge2 src 192.168.1.5 table table3
post-up      ip route add default via 192.168.1.1 dev bridge2 table table3
post-up      ip rule add from 192.168.1.5/32 table table3 
post-up      ip rule add to 192.168.1.5/32 table table3 
post-down    ip route del 192.168.1.0/24 dev bridge2 src 192.168.1.5 table table3
post-down    ip route del default via 192.168.1.1 dev bridge2 table table3
post-down    ip rule del from 192.168.1.5/32 table table3
post-down    ip rule del to 192.168.1.5/32 table table3
```
Restart your system to activate the network settings

 

## Configure network configuration for CentOS
Check for every interface if the configuration file is created. When adding new interfaces, you need to create a new configuration.

First network interface
```sh
vim /etc/sysconfig/network-scripts/ifcfg-eth0
```
Configuration as below
```
DEVICE=eth0
TYPE=Ethernet
ONBOOT=yes
BOOTPROTO=dhcp
NM_CONTROLLED=no
```

Second network interface
```sh
vim /etc/sysconfig/network-scripts/ifcfg-eth1
```
Configuration as below
```
DEVICE=eth1
TYPE=Ethernet
ONBOOT=yes
BOOTPROTO=dhcp
NM_CONTROLLED=no
```

Third network interface
```sh
vim /etc/sysconfig/network-scripts/ifcfg-eth2
```
Configuration as below
```
DEVICE=eth2
TYPE=Ethernet
ONBOOT=yes
BOOTPROTO=dhcp
NM_CONTROLLED=no
``` 

For every interface we need to create a separate routing and rule configuration file.

First network interface
Routes configuration
```sh
vim /etc/sysconfig/network-scripts/route-eth0
```
Configuration as below
```
192.168.1.0/24 dev eth0 src 192.168.1.3 table table1
default via 192.168.1.1 dev eth0 table table1
```
Rules configuration
```sh
vim /etc/sysconfig/network-scripts/rule-eth0
```
Configuration as below
```
from 192.168.1.3/32 table table1
to 192.168.1.3/32 table table1
``` 

Second network interface
Routes configuration
```sh
vim /etc/sysconfig/network-scripts/route-eth1
```
Configuration as below
```
192.168.1.0/24 dev eth1 src 192.168.1.4 table table2
default via 192.168.1.1 dev eth1 table table2
```
Rules configuration
```sh
vim /etc/sysconfig/network-scripts/rule-eth1
```
Configuration as below
```
from 192.168.1.4/32 table table2
to 192.168.1.4/32 table table2
```

Third network interface
Routes configuration
```sh
vim /etc/sysconfig/network-scripts/route-eth2
```
Configuration as below
```
192.168.1.0/24 dev eth2 src 192.168.1.5 table table3
default via 192.168.1.1 dev eth2 table table3
Rules configuration

vim /etc/sysconfig/network-scripts/rule-eth2
Configuration as below

from 192.168.1.5/32 table table3
to 192.168.1.5/32 table table3
```
Restart your system to activate the network settings

</div >

                            </div>
                        </div>
                    </div>
  
  <!-- /.panel -->
                     <div class="panel panel-default">
                        <div class="panel-heading">
                            <h4 class="panel-title">
                                <a class="noCrossRef accordion-toggle" data-toggle="collapse" data-parent="#accordion" href="#collapseTwoNetwork">How do you link a floating ip to an instance?</a>
                            </h4>
                        </div>
                        <div id="collapseTwoNetwork" class="panel-collapse collapse noCrossRef">
                            <div class="panel-body">
<div markdown="1">

Sometimes it’s desirable to use a floating ip. The advantage of using a floating ip is that you can still use it after removing an instance and re-link it to another instance. This is useful when using services, such as a webserver or e-mail server where you don’t want to lose your public IP.

In order to set up a floating ip successfully, please follow the steps below. At the bottom of this webpage you will also find a video with instructions.

prequires

It is not possible to link multiple floating ip addresses to 1 instance.

In the menu under the tab "Network" and subtab "Networking" you must ensure that you’ve created a private network. You can use the internal ip series 192.168.0.0/16, 172.16.0.0/12 or 10.0.0.0/8.

The set-up of an instance

You can skip this step if you’ve already created an instance with a network interface linked to a private network and serves as an example.

Click in the menu on "Compute" and then on "Instances"

Click in the main screen on "LAUNCH INSTANCE"

Enter a name for your Instance

Select a source from the image list

Select a desired Flavor

Select ‘private network’ at networks

Select a matching firewall at ‘Security Groups’

Click on "LAUNCH INSTANCE"

The installation of a floating ip

Click in the menu on "Network" and then on "Floating IPs"

Click on "ALLOCATE IP TO PROJECT" in the main screen and then on "ALLOCATE IP"

In the main screen you’ll now see a floating IP assigned. Click on the floating IP on "ASSOCIATE"

Select at "Port to be associated", the port of the instance which need to be linked to the floating ip

Your floating ip is now linked to your instance. This is immediately active and usable

You are now able to test the floating ip by pinging it from a remote host. It is also possible to check your outgoing traffic by sending a ping externally.

</div >

                            </div>
                        </div>
                    </div>
                    <!-- /.panel -->
          
                   <div class="panel panel-default">
                        <div class="panel-heading">
                            <h4 class="panel-title">
                                <a class="noCrossRef accordion-toggle" data-toggle="collapse" data-parent="#accordion" href="#collapseThreeNetwork">Which MTU settings do you use inside the OpenStack platform?</a>
                            </h4>
                        </div>
                        <div id="collapseThreeNetwork" class="panel-collapse collapse noCrossRef">
                            <div class="panel-body">
<div markdown="1">
We use MTU 1500 (default). Jumbo frames are not supported in the Openstack platform, an MUT lower than 1500 however is.

</div >


                            </div>
                        </div>
                    </div>
                    <!-- /.panel -->
                <div class="panel panel-default">
                        <div class="panel-heading">
                            <h4 class="panel-title">
                                <a class="noCrossRef accordion-toggle" data-toggle="collapse" data-parent="#accordion" href="#collapseFourNetwork">Will the Router external IP address stay the same?</a>
                            </h4>
                        </div>
                        <div id="collapseFourNetwork" class="panel-collapse collapse noCrossRef">
                            <div class="panel-body">
<div markdown="1">
Yes. As long as you do not delete the Router it will keep the same IP address.
</div >


                            </div>
                        </div>
                    </div>
                    <!-- /.panel -->
 
                <div class="panel panel-default">
                        <div class="panel-heading">
                            <h4 class="panel-title">
                                <a class="noCrossRef accordion-toggle" data-toggle="collapse" data-parent="#accordion" href="#collapseFiveNetwork">Why are my Security Groups being removed when I disconnect all networks?</a>
                            </h4>
                        </div>
                        <div id="collapseFiveNetwork" class="panel-collapse collapse noCrossRef">
                            <div class="panel-body">
<div markdown="1">
This is because OpenStack assigns Security Groups to ports. When a network is detached or disconnected the corresponding port is removed, including all the security groups attached to that port.
</div >


                            </div>
                        </div>
                    </div>
                    <!-- /.panel -->
  
                <div class="panel panel-default">
                        <div class="panel-heading">
                            <h4 class="panel-title">
                                <a class="noCrossRef accordion-toggle" data-toggle="collapse" data-parent="#accordion" href="#collapseSixNetwork">What are the requirements for reverse DNS for my OpenStack instance?</a>
                            </h4>
                        </div>
                        <div id="collapseSixNetwork" class="panel-collapse collapse noCrossRef">
                            <div class="panel-body">
<div markdown="1">
The reverse DNS of your instance is actually the name of your OpenStack instance. Before using, we validate the name of your OpenStack instance with the following checks

Is the name that you’ve given the OpenStack instance actually a domain name?
If we lookup the (forward) DNS, do we get a IP address back that is connected to the instance?
If you run a mail server on port 25, does this return the same hostname when we send a HELO / EHLO request?
If all of those checks match, the reverse DNS address will be set to the name of your instance.

If you already have an existing instance in OpenStack, but the name does not yet match those requirements, you can easily change it via the OpenStack API or by using our Skyline interface. We will check once a day if the requirements are met.

If the checks fail, a reverse DNS will be generated. For example vm-<uuid>.public.cloudvps.com
</div >

                            </div>
                        </div>
                    </div>
                    <!-- /.panel -->
          
 
                <div class="panel panel-default">
                        <div class="panel-heading">
                            <h4 class="panel-title">
                                <a class="noCrossRef accordion-toggle" data-toggle="collapse" data-parent="#accordion" href="#collapseSevenNetwork">Through which IP address will my server be communicating if I don't use a Floating IP address?</a>
                            </h4>
                        </div>
                        <div id="collapseSevenNetwork" class="panel-collapse collapse noCrossRef">
                            <div class="panel-body">
<div markdown="1">
In case you don't use an Floating IP address, the server will be communicating with the IP address of your Router as its source address.
You can verify this by issuing the following command:


dig +short myip.opendns.com @resolver1.opendns.com

or

curl ifcfg.me


The response will show you the IP address from which your server is communicating with.
</div >


                            </div>
                        </div>
                    </div>
                    <!-- /.panel -->
  
                <div class="panel panel-default">
                        <div class="panel-heading">
                            <h4 class="panel-title">
                                <a class="noCrossRef accordion-toggle" data-toggle="collapse" data-parent="#accordion" href="#collapseEightNetwork">My Floating IP address is not working?</a>
                            </h4>
                        </div>
                        <div id="collapseEightNetwork" class="panel-collapse collapse noCrossRef">
                            <div class="panel-body">
<div markdown="1">
Please make sure the private network IP address is attached and active on the eth0 interface. Contact support@cloudvps.com with the UUID of the server if the problem persists. Please include which client was used, the date/timestamp of the error and the error itself (if any).
</div >


                            </div>
                        </div>
                    </div>
                    <!-- /.panel -->
 
 
                <div class="panel panel-default">
                        <div class="panel-heading">
                            <h4 class="panel-title">
                                <a class="noCrossRef accordion-toggle" data-toggle="collapse" data-parent="#accordion" href="#collapseNineNetwork">I can’t delete a network?</a>
                            </h4>
                        </div>
                        <div id="collapseNineNetwork" class="panel-collapse collapse noCrossRef">
                            <div class="panel-body">
<div markdown="1">
Please make sure you have no active ports assigned. Disconnnect all related ports from all servers first. Also, you have to delete the router first before you can delete the network.
</div >


                            </div>
                        </div>
                    </div>
                    <!-- /.panel -->
 
 
                <div class="panel panel-default">
                        <div class="panel-heading">
                            <h4 class="panel-title">
                                <a class="noCrossRef accordion-toggle" data-toggle="collapse" data-parent="#accordion" href="#collapseTenNetwork">I can’t delete a router?</a>
                            </h4>
                        </div>
                        <div id="collapseTenNetwork" class="panel-collapse collapse noCrossRef">
                            <div class="panel-body">
<div markdown="1">
Please make sure you have disconnected all active ports assigned.
</div >


                            </div>
                        </div>
                    </div>
                    <!-- /.panel -->
 
 
                <div class="panel panel-default">
                        <div class="panel-heading">
                            <h4 class="panel-title">
                                <a class="noCrossRef accordion-toggle" data-toggle="collapse" data-parent="#accordion" href="#collapseElevenNetwork">How do I convert a public fixed IP address to be a Floating IP address?</a>
                            </h4>
                        </div>
                        <div id="collapseElevenNetwork" class="panel-collapse collapse noCrossRef">
                            <div class="panel-body">
<div markdown="1">
This is not possible. Please remove the public fixed IP address,  add a private network IP address and attach a Floating IP address to it instead.
</div >


                            </div>
                        </div>
                    </div>
                    <!-- /.panel -->
 
 
                <div class="panel panel-default">
                        <div class="panel-heading">
                            <h4 class="panel-title">
                                <a class="noCrossRef accordion-toggle" data-toggle="collapse" data-parent="#accordion" href="#collapseTwelveNetwork">How can I reassign a public fixed IP address to another server?</a>
                            </h4>
                        </div>
                        <div id="collapseTwelveNetwork" class="panel-collapse collapse noCrossRef">
                            <div class="panel-body">
<div markdown="1">
It is not possible to reassign public fixed IP addresses to another server. Please use Floating addresses instead.
</div >


                            </div>
                        </div>
                    </div>
                    <!-- /.panel -->
 
 
                <div class="panel panel-default">
                        <div class="panel-heading">
                            <h4 class="panel-title">
                                <a class="noCrossRef accordion-toggle" data-toggle="collapse" data-parent="#accordion" href="#collapseThirteenNetwork">Does the OpenStack platform support the IPv6 protocol?</a>
                            </h4>
                        </div>
                        <div id="collapseThirteenNetwork" class="panel-collapse collapse noCrossRef">
                            <div class="panel-body">
<div markdown="1">
IPv6 is not yet supported on OpenStack. We hope to offer this in the forseeable future.
</div >


                            </div>
                        </div>
                    </div>
                    <!-- /.panel -->
 
 
                <div class="panel panel-default">
                        <div class="panel-heading">
                            <h4 class="panel-title">
                                <a class="noCrossRef accordion-toggle" data-toggle="collapse" data-parent="#accordion" href="#collapseFourteenNetwork">Can I reserve an IP range for later use?</a>
                            </h4>
                        </div>
                        <div id="collapseFourteenNetwork" class="panel-collapse collapse noCrossRef">
                            <div class="panel-body">
<div markdown="1">
We do not provide support for IP range reservations. You could however reserve as many IP addresses as needed by adding them to you account. They will remain assigend to your account untill you delete them. Please keep in mind that any assigned resources, even if not actively in use will be charged.
</div >


                            </div>
                        </div>
                    </div>
                    <!-- /.panel -->
 

 
                <div class="panel panel-default">
                        <div class="panel-heading">
                            <h4 class="panel-title">
                                <a class="noCrossRef accordion-toggle" data-toggle="collapse" data-parent="#accordion" href="#collapseFifteenNetwork">Can I configure Security Groups to be configure to a server and not to be on a port?</a>
                            </h4>
                        </div>
                        <div id="collapseFifteenNetwork" class="panel-collapse collapse noCrossRef">
                            <div class="panel-body">
<div markdown="1">
No, this is not possible.
</div >


                            </div>
                        </div>
                    </div>
                    <!-- /.panel -->
  
                <div class="panel panel-default">
                        <div class="panel-heading">
                            <h4 class="panel-title">
                                <a class="noCrossRef accordion-toggle" data-toggle="collapse" data-parent="#accordion" href="#collapseSixteenNetwork">Can I still use a hardware firewall when using OpenStack?</a>
                            </h4>
                        </div>
                        <div id="collapseSixteenNetwork" class="panel-collapse collapse noCrossRef">
                            <div class="panel-body">
<div markdown="1">
Yes. Please contact sales@cloudvps.com to inquire more information about the use of hardware firewalls.
</div >


                            </div>
                        </div>
                    </div>
                    <!-- /.panel -->
  
                <div class="panel panel-default">
                        <div class="panel-heading">
                            <h4 class="panel-title">
                                <a class="noCrossRef accordion-toggle" data-toggle="collapse" data-parent="#accordion" href="#collapseSeventeenNetwork">Can I attach a floating IP to a net-public address?</a>
                            </h4>
                        </div>
                        <div id="collapseSeventeenNetwork" class="panel-collapse collapse noCrossRef">
                            <div class="panel-body">
<div markdown="1">
No. You can only attach Floating IP’s to an interface in a private network.
</div >


                            </div>
                        </div>
                    </div>
                    <!-- /.panel -->
 






</div>

{% include links.html %}
