---
title: Manage DNS using the dashboard
tags: [dashboard, dns]
keywords: dashboard, dns
last_updated: May 20, 2019
summary: "How to manage DNS using the dashboard"
sidebar: cloud_sidebar
permalink: cloud_dashboard_dns.html
folder: cloud
---

DNS Zones and reverse DNS for floating IPs can be created and managed using the dashboard

1. [Login to the dashboard](cloud_dashboard_login.html).

1. Select the appropriate project from the drop down menu at the top left.

1. On the Project tab, open the Network tab and click DNS category.

## Create a DNS Zone

1. Select the Zones tab, click Create Zone

1. In the Create Zone dialog box, enter the following values according to the zone you are creating:

   * **Name:** The name of the DNS zone to create
   * **Description:** A description for the DNS zone
   * **Email address:** Email address for the zone SOA record
   * **TTL:** Time to Live of the zone in seconds
   * **Type**: Type of zone to create, Primary or Secondary
    * **Masters:** If the zone is Secondary, the IPs of the master servers

1. Click Submit.

## Create a DNS Record Set

1. Select the Zones tab, click Create Record Set next to the zone you want to add it to

1. In the Create Record Set dialog box, enter the following values according to the record set you are creating:

   * **Type:** The type of DNS record to create
   * **Name:** The name of the record
   * **Description:** A Descript of the record
   * **TTL:** The Time to Live of the record in seconds
   * **Record:** The data for the record

     Click Add Record to add multiple resource records

1. Click Submit.

## Create an Reverse DNS entry

1. Select the Reverse DNS tab, click Set next to the IP you want to managed the reverse DNS of

1. In the Set Domain Name PTR dialog box, enter the following values according to the record set you are creating:

   * **Domain Name:** The fully qualified name for the record
   * **Description:** A description of the record
   * **TTL:** Time to Live of the record in seconds

1. Click Submit.
