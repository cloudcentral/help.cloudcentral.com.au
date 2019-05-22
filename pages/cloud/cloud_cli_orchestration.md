---
title: Manage Orchestration using the CLI
tags: [cli, orchestration]
keywords: cli, orchestration
last_updated: May 20, 2019
summary: "How to manage Orchestration using the CLI"
sidebar: cloud_sidebar
permalink: cloud_cli_orchestration.html
folder: cloud
---

## Confirming you can access a Heat endpoint
Before any Heat commands can be run, your cloud credentials need to be sourced:
```sh
$ source openrc
```
You can confirm that Heat is available with this command:
```sh
$ openstack stack list
```
This should return an empty line

## Preparing to create a stack
Download and register the image:
```sh
$ wget http://cloud.fedoraproject.org/fedora-20.x86_64.qcow2
$ openstack image create \
                      --disk-format=qcow2 \
                      --container-format=bare \
                      --file=fedora-20.x86_64.qcow2 \
                      fedora-20.x86_64
```
Your cloud will have different flavors and images available for launching instances, you can discover what is available by running:
```sh
$ openstack flavor list
$ openstack image list
```
To allow you to SSH into instances launched by Heat, a keypair will be generated:
```sh
$ openstack keypair create heat_key > heat_key.priv
$ chmod 600 heat_key.priv
```
## Launching a stack
Now lets launch a stack, using an example template from the heat-templates repository:
```sh
$ openstack stack create -t https://opendev.org/openstack/heat-templates/raw/src/branch/master/hot/F20/WordPress_Native.yaml --parameter key_name=heat_key --parameter image_id=my-fedora-image --parameter instance_type=m1.small teststack
```
Which will respond:
```sh
+--------------------------------------+-----------+--------------------+----------------------+
| ID                                   | Name      | Status             | Created              |
+--------------------------------------+-----------+--------------------+----------------------+
| 718a712a-2571-4eac-aa03-426de00ecb43 | teststack | CREATE_IN_PROGRESS | 2017-04-11T03:06:24Z |
+--------------------------------------+-----------+--------------------+----------------------+
```
{% include note.html content="Link on Heat template presented in command above should reference on RAW template. In case if it be a “html” page with template, Heat will return an error." %}

{% include note.html content="You cannot rename a stack after it has been launched." %}

## List stacks
List the stacks in your tenant:
```sh
$ openstack stack list
```
## List stack events
List the events related to a particular stack:
```sh
$ openstack stack event list teststack
```
## Describe the wordpress stack
Show detailed state of a stack:
```sh
$ openstack stack show teststack
```
{% include note.html content="After a few seconds, the stack_status should change from IN_PROGRESS to CREATE_COMPLETE." %}

## Verify instance creation
Because the software takes some time to install from the repository, it may be a few minutes before the Wordpress instance is in a running state.

Point a web browser at the location given by the WebsiteURL output as shown by openstack stack output show:
```sh
$ WebsiteURL=$(openstack stack output show teststack WebsiteURL -c output_value -f value)
$ curl $WebsiteURL
```
## Delete the instance when done
{% include note.html content="The list operation will show no running stack." %}

```sh
$ openstack stack delete teststack
$ openstack stack list
```
You can explore other heat commands by referring to the Heat command reference for the OpenStack Command-Line Interface; then read the Template Guide and start authoring your own templates.



