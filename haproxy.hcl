template {
  source = "/consul-template/haproxy.cfg.tpl"
  destination = "/haproxy/haproxy.cfg"
  command = "/usr/sbin/haproxy -D -p /var/run/haproxy.pid  -f /haproxy/haproxy.cfg || true"
}