# Setup

This is my personal setup for my development environment. To begin the setup will use ansible.

First time ?

```sh
mkdir -p ~/Setup
cd ~/Setup
git clone https://github.com/GuillaumeDorschner/Setup.git
cd setup
pip install ansible
sudo ansible-playbook -i hosts setup.yml # sudo is required to install packages
```

Already setup ?

```sh
sudo ansible-playbook -i hosts ~/Setup/setup.yml
```
