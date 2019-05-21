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

1. Select the IKE Policies tab, clock Add IKE Policy

1. In the Add IKE Policy dialog box, enter the following values according to the VPN you are connecting to:

   * Name:
   * Description
   * Authorization algorithm
   * Encryption algorithm
   * IKE version
   * Lifetime units for IKE keys
   * Lifetime values for IKE keys
   * Perfect Forward Secrecy
   * IKE Phase1 negotiation mode

1. Click Add.

   The dashboard shows the IKE Policy

## Create an IPSEC Policy

1. Select the IPSEC Policies tab, clock Add IPSEC Policy

1. In the Add IPSEC Policy dialog box, enter the following values according to the VPN you are connecting to:

   * Name:
   * Description
   * Authorization algorithm
   * Encapsulation mode
   * Encryption algorithm
   * Lifetime units
   * Lifetime values for IKE keys
   * Perfect Forward Secrecy
   * Transform Protocol

1. Click Add.

   The dashboard shows the IPSEC Policy

## Create an VPN Service

1. Select the VPN Services tab, clock Add VPN Service

1. In the Add VPN Service dialog box, enter the following values according to the VPN you are connecting to:

   * Name:
   * Description
   * Router
   * Subnet

1. Click Add.

   The dashboard shows the VPN Service

## Create an IPSEC Site Connection

1. Select the IPSEC Site Connections tab, clock Add IPSEC Site Connections

1. In the Add IPSEC Site Connections dialog box, enter the following values according to the VPN you are connecting to:

   * Name:
   * Description
   * VPN Service associated with this connection
   * IKE Policy associated with this connection
   * IPSEC Policy associated with this connection
   * Peer gateway public IPv4/IPv6 Address or FQDNA
   * Peer router identity for authentication (Peer ID)
   * Remote peer subnet(s)
   * Pre-Shared Key (PSK) string

1. Click Add.

   The dashboard shows the IPSEC Site Connection, its status should be Active.


