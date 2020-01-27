#!/bin/bash -eux

# Configure repos
subscription-manager register --username=${RHSM_USERNAME} --password=${RHSM_PASSWORD} --name=packer-rhel7-$(date +%Y%m%d)-${RANDOM}
subscription-manager attach --auto
#subscription-manager repos --disable=*
subscription-manager repos --enable=rhel-7-server-ansible-2.9-rpms --enable=rhel-7-server-rpms

# Update to last patches
yum -y update --setopt tsflags=nodocs

# Install Ansible.
yum -y install --setopt tsflags=nodocs ansible
yum history package ansible|awk '/Install/ {print $1}' > /tmp/YUM_ID

# Configure /tmp on tmpfs
systemctl enable tmp.mount

# Installing vagrant keys
mkdir ~/.ssh
chmod 700 ~/.ssh
cd ~/.ssh
wget --no-check-certificate 'https://raw.github.com/mitchellh/vagrant/master/keys/vagrant.pub' -O authorized_keys
chmod 600 ~/.ssh/authorized_keys
chown -R vagrant ~/.ssh