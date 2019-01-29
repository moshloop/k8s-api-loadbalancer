#!/bin/bash

set -e
#set the DEBUG env variable to turn on debugging

CONSUL_TEMPLATE=${CONSUL_TEMPLATE:-/usr/local/bin/consul-template}
CONSUL_CONNECT=${CONSUL_CONNECT:-consul.service.consul:8500}
CONSUL_MINWAIT=${CONSUL_MINWAIT:-2s}
CONSUL_MAXWAIT=${CONSUL_MAXWAIT:-10s}
CONSUL_LOGLEVEL=${CONSUL_LOGLEVEL:-info}
PORT=${PORT:-8443}

if [[ -n "$DEBUG" ]]; then
 set -x
 CONSUL_LOGLEVEL=debug
fi

if [[ -n "${CONSUL_TOKEN}" ]]; then
  ctargs="${ctargs} -token ${CONSUL_TOKEN}"
fi

vars=( "$@" )

/usr/sbin/nginx -c /nginx.conf

exec ${CONSUL_TEMPLATE} \
                 -log-level ${CONSUL_LOGLEVEL} \
                 -config /consul.hcl \
                 -wait ${CONSUL_MINWAIT}:${CONSUL_MAXWAIT} \
                 -consul-addr ${CONSUL_CONNECT} ${ctargs} "${vars[@]}"