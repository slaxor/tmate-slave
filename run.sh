#!/bin/sh
if [ -n "${HOST}" ]; then
  hostopt="-h ${HOST}"
fi
/usr/local/bin/create_keys.sh
/usr/local/bin/tmate-slave -p ${PORT?22222} $hostopt
