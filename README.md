# Setup

This is my personal setup for my development environment. To begin the setup will use ansible.

First time ?

```sh
sh -c "$(curl -fsSL setup.install.dorschner.me)"
```

Already setup ?

```sh
ansible-playbook ~/Setup/setup.yml --ask-vault-pass --ask-become-pass
```
