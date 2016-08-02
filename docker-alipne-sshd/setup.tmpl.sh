#!/bin/sh
set -xe
apk update
apk add openssh

mkdir /root/.ssh
chmod 700 /root/.ssh
cat > /root/.ssh/authorized_keys << 'EOS'
###AUTHORIZED_KEYS###
EOS
chmod 600 /root/.ssh/authorized_keys

echo 'PermitRootLogin without-password' >> /etc/ssh/sshd_config
echo 'PasswordAuthentication no'        >> /etc/ssh/sshd_config

ssh-keygen -t rsa     -N '' -f /etc/ssh/ssh_host_rsa_key
ssh-keygen -t dsa     -N '' -f /etc/ssh/ssh_host_dsa_key
ssh-keygen -t ecdsa   -N '' -f /etc/ssh/ssh_host_ecdsa_key
ssh-keygen -t ed25519 -N '' -f /etc/ssh/ssh_host_ed25519_key

