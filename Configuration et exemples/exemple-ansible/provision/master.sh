#!/bin/sh
# vim: set ts=2 sw=2 et:

# arreter le script à la moindre erreur 
# - commande en echec
# - variable non définie
set -e
set -u

# on prépare APT pour l'installation de paquets
# de façon automatisée (sans poser de questions)
export DEBIAN_FRONTEND=noninteractive

apt-get update 
apt-get install -y ansible vim ntp

# on génère des clefs (seulement si elles n'existent pas)
MACHINES="master web data"
mkdir -p /vagrant/keys
for machine in $MACHINES ; do 
  keyfile="/vagrant/keys/${machine}_rsa"
  if ! [ -f "$keyfile" ]; then
    ssh-keygen -P "" -f "$keyfile"
  fi
done
# on en garde une copie sur master (en tant que vagrant)
SSH_DIR="/home/vagrant/.ssh"
rm -fr "$SSH_DIR/ansible"
cp -a /vagrant/keys "$SSH_DIR/ansible"
chown vagrant:vagrant "$SSH_DIR/ansible"
chmod 700 "$SSH_DIR/ansible"
chmod 600 "$SSH_DIR/ansible"/*
sync

echo "SUCCESS"
