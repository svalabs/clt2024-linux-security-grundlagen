# Vagrant

## Usage

Run the following command to create and configure the VMs:

```shell
$ vagrant up
```

This can take up to 30 minutes.

## Testing

First create a SSH configuration file from your current Vagrant scenario:

```shell
$ vagrant ssh-config > .vagrant/ssh-config
```

The will create a file `.vagrant/ssh-config` that might look like this:

```text
Host controller
  HostName 127.0.0.1
  User vagrant
  Port 2222
  UserKnownHostsFile /dev/null
  StrictHostKeyChecking no
  PasswordAuthentication no
  IdentityFile [...]/.vagrant/machines/controller/virtualbox/private_key
  IdentitiesOnly yes
  LogLevel FATAL

Host node1
  HostName 127.0.0.1
  User vagrant
  Port 2200
  UserKnownHostsFile /dev/null
  StrictHostKeyChecking no
  PasswordAuthentication no
  IdentityFile [...]/.vagrant/machines/node1/virtualbox/private_key
  IdentitiesOnly yes
  LogLevel FATAL

Host node2
  HostName 127.0.0.1
  User vagrant
  Port 2201
  UserKnownHostsFile /dev/null
  StrictHostKeyChecking no
  PasswordAuthentication no
  IdentityFile [...]/.vagrant/machines/node2/virtualbox/private_key
  IdentitiesOnly yes
  LogLevel FATAL
```

Don't forget to run tests:

```shell
$ py.test ../ansible/test_generic.py --sudo --ssh-config=.vagrant/ssh-config --hosts=controller,node1,node2
$ py.test ../ansible/test_controller.py --sudo --ssh-config=.vagrant/ssh-config --hosts=controller
$ py.test ../ansible/test_node1.py --sudo --ssh-config=.vagrant/ssh-config --hosts=node1
$ py.test ../ansible/test_node2.py --sudo --ssh-config=.vagrant/ssh-config --hosts=node2
```

**Note**: It can take up to an hour for OpenVAS to download security definitions.
