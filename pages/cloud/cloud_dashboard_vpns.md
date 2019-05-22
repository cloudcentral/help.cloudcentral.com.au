---
title: Manage VPNs using the dashboard
tags: [dashboard, vpn]
keywords: dashboard, vpn
last_updated: May 20, 2019
summary: "How to manage VPNs using the dashboard"
sidebar: cloud_sidebar
permalink: cloud_dashboard_vpns.html
folder: cloud
---

Virtual Private Networks can be created in order to provide secured site to site connectivity.

1. [Login to the dashboard](cloud_dashboard_login.html).

1. Select the appropriate project from the drop down menu at the top left.

1. On the Project tab, open the Network tab and click VPN category.

## Create an IKE policy

{% include note.html content="This step can be skipped if you already have a compatible IKE Policy." %}

1. Select the IKE Policies tab, click Add IKE Policy

1. In the Add IKE Policy dialog box, enter the following values according to the VPN you are connecting to:

   * Name: A name for the IKE Policy
   * Description: A description for the IKE Policy
   * Authorization algorithm: Details as agreed with the remote VPN provider
   * Encryption algorithm Details as agreed with the remote VPN provider:
   * IKE version Details as agreed with the remote VPN provider:
   * Lifetime units for IKE keys Details as agreed with the remote VPN provider:
   * Lifetime values for IKE keys Details as agreed with the remote VPN provider:
   * Perfect Forward Secrecy Details as agreed with the remote VPN provider:
   * IKE Phase1 negotiation mode Details as agreed with the remote VPN provider:

1. Click Add.

   The dashboard shows the IKE Policy

## Create an IPSEC Policy

{% include note.html content="This step can be skipped if you already have a compatible IPSEC Policy." %}

1. Select the IPSEC Policies tab, click Add IPSEC Policy

1. In the Add IPSEC Policy dialog box, enter the following values according to the VPN you are connecting to:

   * Name: A name for the IPSEC Policy
   * Description: A description for the IPSEC Policy
   * Authorization algorithm: Details as agreed with the remote VPN provider:
   * Encapsulation mode: Details as agreed with the remote VPN provider:
   * Encryption algorithm: Details as agreed with the remote VPN provider:
   * Lifetime units: Details as agreed with the remote VPN provider:
   * Lifetime values for IKE keys: Details as agreed with the remote VPN provider:
   * Perfect Forward Secrecy: Details as agreed with the remote VPN provider:
   * Transform Protocol: Details as agreed with the remote VPN provider:

1. Click Add.

   The dashboard shows the IPSEC Policy

## Create a VPN Service

{% include note.html content="This step can be skipped if you already have a compatible VPN Service." %}

1. Select the VPN Services tab, click Add VPN Service

1. In the Add VPN Service dialog box, enter the following values according to the VPN you are connecting to:

   * Name: The name of the VPN Service
   * Description: A description for the VPN Service
   * Router: Select the router to attach the VPN Service to
   * Subnet: Leave this blank

1. Click Add.

   The dashboard shows the VPN Service

## Create Endpoint Groups

1. Select the Endpoint Groups tab, click Add Endpoint Group

1. In the Add Endpoint Group dialog box, enter the following details

   * Name: The name of the Endpoint Group
   * Description: A description for the Endpoint group
   * Type: The type of the Endpoint Group, (CIDR or Subnet)

   For the local networks, select 'Subnet' and select the local subnets you want routed over the VPN.

Repeat the process for the remote networks, using the 'CIDR' type, and entering the CIDR of the remote networks to route.

## Create an IPSEC Site Connection

1. Select the IPSEC Site Connections tab, click Add IPSEC Site Connections

1. In the Add IPSEC Site Connections dialog box, enter the following values according to the VPN you are connecting to:

   * Name: The name of the IPSEC Site Connection
   * Description: A description for the IPSEC Site Connection
   * VPN Service associated with this connection: Select the VPN Service created above
   * Endpoint group for local subnet(s): Select the local Endpoint Group created above
   * IKE Policy associated with this connection: Select the IKE Policy created above
   * IPSEC Policy associated with this connection: Select the IPSEC Policy created above
   * Peer gateway public IPv4/IPv6 Address or FQDN: Enter the remote IP of the IPSEC Site Connection
   * Peer router identity for authentication (Peer ID): Enter the remote IP of the IPSEC Site Connection
   * Remote peer subnet(s): Leave this blank
   * Pre-Shared Key (PSK) string: Enter the password for the IPSEC Site Connection

1. Click Add.

   The dashboard shows the IPSEC Site Connection, its status should be Active.


