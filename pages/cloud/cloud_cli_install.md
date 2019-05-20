---
title: Installing the CLI tools
tags: [cli,getting_started]
keywords: cli
last_updated: April 11, 2018
summary: "How to install the Openstack CLI tools on various operating systems"
sidebar: cloud_sidebar
permalink: cloud_cli_install.html
folder: cloud
---

Install the prerequisite software and the Python package for each OpenStack client.

## Install the prerequisite software
Most Linux distributions include packaged versions of the command-line clients that you can install directly, see [Installing from packages][cloud_cli_install.html#packages].

If you need to install the source package for the command-line package, the following table lists the software needed to run the command-line clients, and provides installation instructions as needed.

**OpenStack command-line clients prerequisites**

|Prerequisite|Description|
|------------|-----------|
|Python 2.7 or later|Currently, the clients do not support Python 3.|
|setuptools package|Installed by default on Mac OS X.<br/><br/>Many Linux distributions provide packages to make setuptools easy to install. Search your package manager for setuptools to find an installation package. If you cannot find one, download the setuptools package directly from https://pypi.python.org/pypi/setuptools.<br/><br/>The recommended way to install setuptools on Microsoft Windows is to follow the documentation provided on the setuptools website (https://pypi.python.org/pypi/setuptools).<br/><br/>Another option is to use the unofficial binary installer maintained by Christoph Gohlke (http://www.lfd.uci.edu/~gohlke/pythonlibs/#setuptools).|
|pip package|To install the clients on a Linux, Mac OS X, or Microsoft Windows system, use pip. It is easy to use, ensures that you get the latest version of the clients from the Python Package Index, and lets you update or remove the packages later on.<br/><br/>Since the installation process compiles source files, this requires the related Python development package for your operating system and distribution.<br/><br/>Install pip through the package manager for your system:<br/><br/>**MacOS**<br/><br/>```# easy_install pip```<br/><br/>**Microsoft Windows**<br/><br/>Ensure that the C:\Python27\Scripts directory is defined in the PATH environment variable, and use the easy_install command from the setuptools package:<br/><br/>```C:\>easy_install pip```<br/><br/>Another option is to use the unofficial binary installer provided by Christoph Gohlke (http://www.lfd.uci.edu/~gohlke/pythonlibs/#pip).<br/><br/>**Ubuntu or Debian**<br/><br/>```# apt install python-dev python-pip```<br/><br/>Note that extra dependencies may be required, per operating system, depending on the package being installed, such as is the case with Tempest.<br/><br/>**Red Hat Enterprise Linux, CentOS, or Fedora**<br/><br/>A packaged version enables you to use yum to install the package:<br/><br/>```# yum install python-devel python-pip```<br/><br/>There are also packaged versions of the clients available in RDO that enable yum to install the clients as described in Installing_from_packages.<br/><br/>**SUSE Linux Enterprise Server**<br/><br/>A packaged version available in the Open Build Service enables you to use YaST or zypper to install the package.<br/><br/>First, add the Open Build Service repository:<br/><br/>```# zypper addrepo -f obs://Cloud:OpenStack:Mitaka/SLE_12_SP1 Mitaka```<br/><br/>Then install pip and use it to manage client installation:<br/><br/>```# zypper install python-devel python-pip```<br/><br/>There are also packaged versions of the clients available that enable zypper to install the clients as described in Installing_from_packages.<br/><br/>**openSUSE**<br/><br/>You can install pip and use it to manage client installation:<br/><br/>```# zypper install python-devel python-pip```<br/><br/>There are also packaged versions of the clients available that enable zypper to install the clients as described in Installing_from_packages.|

## Install the OpenStack client
The following example shows the command for installing the OpenStack client with pip, which supports multiple services.
```sh
# pip install python-openstackclient
```
The following individual clients are deprecated in favor of a common client. Instead of installing and learning all these clients, we recommend installing and using the OpenStack client. You may need to install an individual project’s client because coverage is not yet sufficient in the OpenStack client. If you need to install an individual client’s project, replace the ```PROJECT``` name in this pip install command using the list below.
```sh
# pip install python-PROJECTclient
```
* ```barbican``` - Key Manager Service API
* ```cinder``` - Block Storage API and extensions
* ```glance``` - Image service API
* ```neutron``` - Networking API
* ```nova``` - Compute API and extensions
* ```swift``` - Object Storage API

## Installing with pip
Use pip to install the OpenStack clients on a Linux, Mac OS X, or Microsoft Windows system. It is easy to use and ensures that you get the latest version of the client from the Python Package Index. Also, pip enables you to update or remove a package.

Install each client separately by using the following command:

For Mac OS X or Linux:
```sh
# pip install python-PROJECTclient
```
For Microsoft Windows:
```sh
C:\>pip install python-PROJECTclient
```

## Installing from packages {#packages}
RDO, openSUSE, SUSE Linux Enterprise, Debian, and Ubuntu have client packages that can be installed without pip.

On Red Hat Enterprise Linux, CentOS, or Fedora, use yum to install the clients from the packaged versions available in RDO:
```sh
# yum install python-PROJECTclient
```
For Ubuntu or Debian, use apt-get to install the clients from the packaged versions:
```sh
# apt-get install python-PROJECTclient
```
For openSUSE, use zypper to install the clients from the distribution packages service:
```sh
# zypper install python-PROJECTclient
```
For SUSE Linux Enterprise Server, use zypper to install the clients from the distribution packages in the Open Build Service. First, add the Open Build Service repository:
```sh
# zypper addrepo -f obs://Cloud:OpenStack:Mitaka/SLE_12_SP1 Mitaka
```
Then you can install the packages:
```sh
# zypper install python-PROJECTclient
```
## Upgrade or remove clients
To upgrade a client, add the --upgrade option to the pip install command:
```sh
# pip install --upgrade python-PROJECTclient
```
To remove the client, run the pip uninstall command:
```sh
# pip uninstall python-PROJECTclient
```

{% include links.html %}
