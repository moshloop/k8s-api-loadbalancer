# tcp-loadbalancer

Dynamic TCP load balancer using nginx and consul-template. Designed to be used for discovering and load balancing across kubernetes masters.

Loosely modelled after https://github.com/CiscoCloud/haproxy-consul

```bash
docker run --rm -e SERVICE_NAME=cluster-c -e CONSUL_CONNECT=consul:8500 moshloop/tcp-loadbalancer
```

Variable | Description | Default
---------|-------------|---------
`PORT`  | The port to listen on | `8443`
`SERVICE_NAME`  | The consul service to load balance |
`CONSUL_CONNECT`  | The consul connection | `consul.service.consul:8500`
`CONSUL_LOGLEVEL` | Valid values are "debug", "info", "warn", and "err". | `debug`
`CONSUL_TOKEN`    | The [Consul API token](http://www.consul.io/docs/internals/acl.html) |
