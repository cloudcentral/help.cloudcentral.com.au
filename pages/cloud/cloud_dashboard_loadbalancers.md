---
title: Manage Load balancers using the dashboard
tags: [dashboard, loadbalancer]
keywords: dashboard, loadbalancer
last_updated: May 20, 2019
summary: "How to manage Load balancers using the dashboard"
sidebar: cloud_sidebar
permalink: cloud_dashboard_loadbalancers.html
folder: cloud
---

Load balancers can be created to direct traffic to internal instances spread over a pool of hosts.

## Create a Load Balancer

1. [Login to the dashboard](cloud_dashboard_login.html).

1. Select the appropriate project from the drop down menu at the top left.

1. On the Project tab, open the Network tab and click Load Balancers category.

1. Click '+ Add Load Balancer'

1. In the Add Load Balancer dialog box, enter the following values:

   * Name: A name for the Load Balancer
   * Description: A description for the Load Balancer
   * IP Address: Optional internal IP address of the Load Balancer
   * Subnet: Select the internal subnet for the Load Balancer

1. Click 'Listener Details' button, enter the following values:

   * Name: A name for the Listener
   * Description: A description for the Listener
   * Protocol: The protocol for the Listener (HTTP, TCP, TERMINATED_HTTPS or HTTPS)
   * Port: The port for the Listener
   * Client Data Timeout:
   * TCP Inspect Timeout:
   * Member Connect Timeout:
   * Member Data Timeout:
   * Connection Limit:
   * Insert Headers
     * X-Forwarded-For:
     * X-Forwarded-Port:

1. Click 'Pool Details' button, enter the following values:

   * Name: A name for the Pool
   * Description: A description for the Pool
   * Algorithm: The algorithm to use for balancing over the pool (LEAST_CONNECTIONS, ROUND_ROBIN, SOURCE_IP)
   * Session Persistance: Persist sessions to backend node based on (SOURCE_IP, HTTP_COOKIE, APP_COOKIE)

1. Click 'Pool Member' button, enter the following values:

   1. Click 'Add' next to the members for the pool
   1. Enter the backend port for each member added

1. Click 'Monitor Details' button, enter the following values:

   * Name: A name for the Health Monitor
   * Type: The type of Health Monitor (HTTP, HTTPS, TCP, PING, TLS-HELLO)
   * Max Retries Down:
   * Delay (sec):
   * Max Retries:
   * Timeout (sec):

1. Click 'Create Load Balancer'

   The dashboard shows the Load Balancer

## Assigning a floating IP

To make the load balanced service available externally, you can assign a floating ip.

1. [Login to the dashboard](cloud_dashboard_login.html).

1. Select the appropriate project from the drop down menu at the top left.

1. On the Project tab, open the Network tab and click Load Balancers category.

1. Click 'Floating IP' from the action dropdown

   1. Select the Network to assign the floating IP from

1. Click Add

   The dashboard shows the Load Balancer

## Layer 7 processing

Load balancers can be configured to perform advanced later 7 processing on requests [using the CLI][cloud_cli_loadbalancers_layer7]

{% include links.html %}
