#!/bin/sh

set -e
set -u


# on prépare 
mkdir -p /root/.ssh

# on nettoie
sed -i '/ssh-rsa.*root@master/d' /root/.ssh/authorized_keys

# on ajoute la clef
hostname="$(hostname)"
cat "/vagrant/keys/${hostname}_rsa.pub" \
	>> /root/.ssh/authorized_keys

# on corrige les permissions
chmod 700 /root/.ssh
chmod 600 /root/.ssh/authorized_keys

echo "SUCCESS"
