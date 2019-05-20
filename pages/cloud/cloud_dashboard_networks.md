---
title: Create and manage networks using the Dashboard
tags: [dashboard, networks]
keywords: dashboard, network, router
last_updated: April 11, 2018
summary: "How to create and manage networks, routers and ports"
sidebar: cloud_sidebar
permalink: cloud_dashboard_networks.html
folder: cloud
---

The OpenStack Networking service provides a scalable system for managing the network connectivity within an OpenStack cloud deployment. It can easily and quickly react to changing network needs (for example, creating and assigning new IP addresses).

Networking in OpenStack is complex. This section provides the basic instructions for creating a network and a router. For detailed information about managing networks, refer to the OpenStack Administrator Guide.

## Create a network
1. [Log in to the dashboard](cloud_dashboard_login.html).

1. Select the appropriate project from the drop down menu at the top left.

1. On the Project tab, open the Network tab and click Networks category.

1. Click Create Network.

1. In the Create Network dialog box, specify the following values.

   - Network tab

     - **Network Name**: Specify a name to identify the network.

     - **Shared**: Share the network with other projects. Non admin users are not allowed to set shared option.

     - **Admin State**: The state to start the network in.

     - **Create Subnet**: Select this check box to create a subnet

       You do not have to specify a subnet when you create a network, but if you do not specify a subnet, the network can not be attached to an instance.

   - Subnet tab

     - **Subnet Name**: Specify a name for the subnet.

     - **Network Address**: Specify the IP address for the subnet.

     - **IP Version**: Select IPv4 or IPv6.

     - **Gateway IP**: Specify an IP address for a specific gateway. This parameter is optional.

     - **Disable Gateway**: Select this check box to disable a gateway IP address.

   - Subnet Details tab

     - **Enable DHCP**: Select this check box to enable DHCP.

     - **Allocation Pools**: Specify IP address pools.

     - **DNS Name Servers**: Specify a name for the DNS server.

     - **Host Routes**: Specify the IP address of host routes.

1. Click Create.

   The dashboard shows the network on the Networks tab.

## Create a router
1. [Log in to the dashboard](cloud_dashboard_login.html).

1. Select the appropriate project from the drop down menu at the top left.

1. On the Project tab, open the Network tab and click Routers category.

1. Click Create Router.

1. In the Create Router dialog box, specify a name for the router and External Network, and click Create Router.

   The new router is now displayed in the Routers tab.

1. To connect a private network to the newly created router, perform the following steps:

   1. On the Routers tab, click the name of the router.

   1. On the Router Details page, click the Interfaces tab, then click Add Interface.

   1. In the Add Interface dialog box, select a Subnet.

      Optionally, in the Add Interface dialog box, set an IP Address for the router interface for the selected subnet.

      If you choose not to set the IP Address value, then by default OpenStack Networking uses the first host IP address in the subnet.

      The Router Name and Router ID fields are automatically updated.

1. Click Add Interface.

You have successfully created the router. You can view the new topology from the Network Topology tab.

## Create a port

1. [Log in to the dashboard](cloud_dashboard_login.html).

1. Select the appropriate project from the drop-down menu at the top left.

1. On the Admin tab, click Networks category.

1. Click on the Network Name of the network in which the port has to be created.

1. In the Create Port dialog box, specify the following values.

   **Name**: Specify name to identify the port.

   **Device ID**: Device ID attached to the port.

   **Device Owner**: Device owner attached to the port.

   **Binding Host**: The ID of the host where the port is allocated.

   **Binding VNIC Type**: Select the VNIC type that is bound to the neutron port.

1. Click Create Port.

   The new port is now displayed in the Ports list.
