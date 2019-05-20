---
title: Create and manage VPNs using the CLI
tags: [cli, vpn]
keywords: cli, vpn, environment
last_updated: April 11, 2018
summary: "How to setup VPNS using the CLI"
sidebar: cloud_sidebar
permalink: cloud_cli_vpns.html
folder: cloud
---

Create the IKE policy, IPsec policy, VPN service, local endpoint group and peer endpoint group. Then, create an IPsec site connection that applies the above policies and service.

1. Create an IKE policy:
    ```sh
    $ openstack vpn ike policy create ikepolicy
      +-------------------------------+----------------------------------------+
      | Field                         | Value                                  |
      +-------------------------------+----------------------------------------+
      | Authentication Algorithm      | sha1                                   |
      | Description                   |                                        |
      | Encryption Algorithm          | aes-128                                |
      | ID                            | 735f4691-3670-43b2-b389-f4d81a60ed56   |
      | IKE Version                   | v1                                     |
      | Lifetime                      | {u'units': u'seconds', u'value': 3600} |
      | Name                          | ikepolicy                              |
      | Perfect Forward Secrecy (PFS) | group5                                 |
      | Phase1 Negotiation Mode       | main                                   |
      | Project                       | 095247cb2e22455b9850c6efff407584       |
      | project_id                    | 095247cb2e22455b9850c6efff407584       |
      +-------------------------------+----------------------------------------+
    ```
1. Create an IPsec policy:
    ```sh
    $ openstack vpn ipsec policy create ipsecpolicy
      +-------------------------------+----------------------------------------+
      | Field                         | Value                                  |
      +-------------------------------+----------------------------------------+
      | Authentication Algorithm      | sha1                                   |
      | Description                   |                                        |
      | Encapsulation Mode            | tunnel                                 |
      | Encryption Algorithm          | aes-128                                |
      | ID                            | 4f3f46fc-f2dc-4811-a642-9601ebae310f   |
      | Lifetime                      | {u'units': u'seconds', u'value': 3600} |
      | Name                          | ipsecpolicy                            |
      | Perfect Forward Secrecy (PFS) | group5                                 |
      | Project                       | 095247cb2e22455b9850c6efff407584       |
      | Transform Protocol            | esp                                    |
      | project_id                    | 095247cb2e22455b9850c6efff407584       |
      +-------------------------------+----------------------------------------+
    ```
1. Create a VPN service:
    ```sh
    $ openstack vpn service create vpn \
      --router 9ff3f20c-314f-4dac-9392-defdbbb36a66
      +----------------+--------------------------------------+
      | Field          | Value                                |
      +----------------+--------------------------------------+
      | Description    |                                      |
      | Flavor         | None                                 |
      | ID             | 9f499f9f-f672-4ceb-be3c-d5ff3858c680 |
      | Name           | vpn                                  |
      | Project        | 095247cb2e22455b9850c6efff407584     |
      | Router         | 9ff3f20c-314f-4dac-9392-defdbbb36a66 |
      | State          | True                                 |
      | Status         | PENDING_CREATE                       |
      | Subnet         | None                                 |
      | external_v4_ip | 192.168.20.7                         |
      | external_v6_ip | 2001:db8::7                          |
      | project_id     | 095247cb2e22455b9850c6efff407584     |
      +----------------+--------------------------------------+
    ```
   {% include note.html content="Please do not specify --subnet option in this case." %}

   The Networking openstackclient requires a router (Name or ID) and name.

1. Create local endpoint group:
    ```sh
    $ openstack vpn endpoint group create ep_subnet \
      --type subnet \
      --value 1f888dd0-2066-42a1-83d7-56518895e47d
      +-------------+-------------------------------------------+
      | Field       | Value                                     |
      +-------------+-------------------------------------------+
      | Description |                                           |
      | Endpoints   | [u'1f888dd0-2066-42a1-83d7-56518895e47d'] |
      | ID          | 667296d0-67ca-4d0f-b676-7650cf96e7b1      |
      | Name        | ep_subnet                                 |
      | Project     | 095247cb2e22455b9850c6efff407584          |
      | Type        | subnet                                    |
      | project_id  | 095247cb2e22455b9850c6efff407584          |
      +-------------+-------------------------------------------+
    ```
   {% include note.html content="The type of a local endpoint group must be subnet." %}

1. Create peer endpoint group:
    ```sh
    $ openstack vpn endpoint group create ep_cidr \
      --type cidr \
      --value 192.168.1.0/24
      +-------------+--------------------------------------+
      | Field       | Value                                |
      +-------------+--------------------------------------+
      | Description |                                      |
      | Endpoints   | [u'192.168.1.0/24']                  |
      | ID          | 5c3d7f2a-4a2a-446b-9fcf-9a2557cfc641 |
      | Name        | ep_cidr                              |
      | Project     | 095247cb2e22455b9850c6efff407584     |
      | Type        | cidr                                 |
      | project_id  | 095247cb2e22455b9850c6efff407584     |
      +-------------+--------------------------------------+
    ```

   {% include note.html content="The type of a peer endpoint group must be cidr." %}

1. Create an ipsec site connection:
    ```sh
    $ openstack vpn ipsec site connection create conn \
      --vpnservice vpn \
      --ikepolicy ikepolicy \
      --ipsecpolicy ipsecpolicy \
      --peer-address 192.168.20.9 \
      --peer-id 192.168.20.9 \
      --psk secret \
      --local-endpoint-group ep_subnet \
      --peer-endpoint-group ep_cidr
      +--------------------------+--------------------------------------------------------+
      | Field                    | Value                                                  |
      +--------------------------+--------------------------------------------------------+
      | Authentication Algorithm | psk                                                    |
      | Description              |                                                        |
      | ID                       | 07e400b7-9de3-4ea3-a9d0-90a185e5b00d                   |
      | IKE Policy               | 735f4691-3670-43b2-b389-f4d81a60ed56                   |
      | IPSec Policy             | 4f3f46fc-f2dc-4811-a642-9601ebae310f                   |
      | Initiator                | bi-directional                                         |
      | Local Endpoint Group ID  | 667296d0-67ca-4d0f-b676-7650cf96e7b1                   |
      | Local ID                 |                                                        |
      | MTU                      | 1500                                                   |
      | Name                     | conn                                                   |
      | Peer Address             | 192.168.20.9                                           |
      | Peer CIDRs               |                                                        |
      | Peer Endpoint Group ID   | 5c3d7f2a-4a2a-446b-9fcf-9a2557cfc641                   |
      | Peer ID                  | 192.168.20.9                                           |
      | Pre-shared Key           | secret                                                 |
      | Project                  | 095247cb2e22455b9850c6efff407584                       |
      | Route Mode               | static                                                 |
      | State                    | True                                                   |
      | Status                   | PENDING_CREATE                                         |
      | VPN Service              | 9f499f9f-f672-4ceb-be3c-d5ff3858c680                   |
      | dpd                      | {u'action': u'hold', u'interval': 30, u'timeout': 120} |
      | project_id               | 095247cb2e22455b9850c6efff407584                       |
      +--------------------------+--------------------------------------------------------+
    ```

   {% include note.html content="Please do not specify --peer-cidr option in this case. Peer CIDR(s) are provided by a peer endpoint group." %}

