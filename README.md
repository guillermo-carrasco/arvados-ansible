Ansible playbook to deploy [Arvados][arvados] components.

# Playbook
The `arvados.yaml` file contains the definition of the playbook. It tells ansible what and where to
install to deploy an Arvados cluster.

## How to run

### Quickstart

Make sure you tweaked `group_vars/all` as indicated in next section, then run:

```
ansible-galaxy install -r requirements.yml --ignore-errors --force -p roles && vagrant up
```

### Variables
Edit the file `group_vars/all` and set username and password that ansible will use to deploy the roles.
Have in mind that this user **needs** root privileges to edit system files.

### Inventory file
An inventory file is a file ansible uses to know where to run the playbook. Have a look at cluster-vm
and follow the example. You just need to add the IPs/hostnames of the nodes you want to run the workbench,
the Keep filesystem, etc. under the corresponding section in the inventory. Ansible will then take care
of installing the corresponding packages in each node.

# Testing Arvados
Using [Vagrant](https://www.vagrantup.com/), you can easily create an Arvados cluster to play around with it.
In this repository you'll find the necessary Vagrantfile that will create and provision the cluster
using this same recipe. After making sure Vagrant is installed, just type `vagrant up` and wait for
the cluster to be created and provisioned.

The cluster is composed by the following nodes, following [Arvados installation guide][installation]

| Function | Number of nodes | VM name | Resources (mem in MB)
| -------- | :-------------: | :-----: | :-------------------:
|Arvados API, Crunch dispatcher, Git, Websockets and Workbench | 1 | workbench | 1024
|Arvados Compute node | 1 | compute | 1024
|Arvados Keepproxy server | 1 | keep | 512
|Arvados Keepstore servers | 2 | keepstore[1,2] | 512
|Arvados Shell server | 1 | shell | 512
|Arvados SSO server | 1 | sso | 512

**Note**: As you can see, you're going to need 4096MB (4GB) of available memory on your system to run this
cluster.

The cluster nodes will run CentOS 6, since is the operating system I needed to tests for, but Pull Requests
for other OS are more than welcome!

# Important notes

## Passenger role
Passenger role [needs SELinux disabled][SELinux] as a requirement, if you don't want this, you'll need
to follow the instructions in the previous link and upgrade your kernel version to a version >= 2.6.39.

## SSO Server

### SSL certificate

Since this ansible recipe was intended to provision a testing cluster, SSL security has been disabled
by choice for convinience. Please read carefully the section [configure your web server](http://doc.arvados.org/install/install-sso.html)
in Arvados' documentation to properly configure a secure server.

### SELinux
SELinux will be disabled to play nicely with old kernels and passenger, if you don't want that, remove
the variable `DISABLE_SELINUX` in the Arvados role variables file.

[arvados]: https://arvados.org/
[SELinux]: https://www.phusionpassenger.com/library/walkthroughs/deploy/ruby/ownserver/nginx/oss/el6/install_passenger.html
[installation]: http://doc.arvados.org/install/install-manual-prerequisites.html
