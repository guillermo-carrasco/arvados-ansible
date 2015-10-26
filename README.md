Ansible playbook to deploy [Arvados][arvados] components.

# Playbook
The `arvados.yaml` file contains the definition of the playbook. It tells ansible what and where to
install to deploy an Arvados cluster.

## How to run

### Variables
Edit the file `group_vars/all` and set username and password that ansible will use to deploy the roles.
Have in mind that this user **needs** root privileges to edit system files.

### Inventory file
An inventory file is a file ansible uses to know where to run the playbook. Have a look at cluster-vm
and follow the example. You just need to add the IPs/hostnames of the nodes you want to run the workbench,
the Keep filesystem, etc. under the corresponding section in the inventory. Ansible will then take care
of installing the corresponding packages in each node.

# Important notes

## Passenger role
Passenger role [needs SELinux disabled][SELinux] as a requirement, if you don't want this, you'll need
to follow the instructions in the previous link and upgrade your kernel version to a version >= 2.6.39.

## SSO Server SSL certificate
Since this ansible recipe was intended to provision a testing cluster, SSL security has been disabled
by choice for convinience. Please read carefully the section [configure your web server](http://doc.arvados.org/install/install-sso.html)
in Arvados' documentation to properly configure a secure server. 

[arvados]: https://arvados.org/
[SELinux]: https://www.phusionpassenger.com/library/walkthroughs/deploy/ruby/ownserver/nginx/oss/el6/install_passenger.html
