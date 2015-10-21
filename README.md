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

# Requirements

Make sure to install the following roles _before_ running this playbook:

    ansible-galaxy install rvm_io.rvm1-ruby


[arvados]: https://arvados.org/
