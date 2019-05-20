---
title: Cloud Platform Networking FAQ
permalink: cloud_faq_networking.html
sidebar: cloud_sidebar
tags: cloud, faq, network
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
 
</div>

{% include links.html %}
