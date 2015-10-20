Ansible playbook to deploy [Arvados][arvados] components.

[arvados]: https://arvados.org/

## How to run

### Variables
Edit the file `group_vars/all` and set username and password that ansible will use to deploy the roles.
Have in mind that this user **needs** root privileges to edit system files. 
