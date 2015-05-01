#!/bin/sh

if [ ! -f /keys/ssh_host_ecdsa_key ];
then
		mkdir -p /keys
		ssh-keygen -t dsa -f /keys/ssh_host_dsa_key -N ''
		ssh-keygen -t rsa -f /keys/ssh_host_rsa_key -N ''
		ssh-keygen -t ecdsa -f /keys/ssh_host_ecdsa_key -N ''
fi

DSA=`ssh-keygen -l -f /keys/ssh_host_dsa_key 2>&1 | cut -d\  -f 2`
RSA=`ssh-keygen -l -f /keys/ssh_host_rsa_key 2>&1 | cut -d\  -f 2`
ECDSA=`ssh-keygen -l -f /keys/ssh_host_ecdsa_key 2>&1 | cut -d\  -f 2`

echo Add this to your ~/.tmate.conf file
echo set -g tmate-server-host ${HOST:-`hostname`}
echo set -g tmate-server-port ${PORT?22222}
echo set -g tmate-server-rsa-fingerprint   \"$RSA\"
echo set -g tmate-server-dsa-fingerprint   \"$DSA\"
echo set -g tmate-server-ecdsa-fingerprint   \"$ECDSA\"
