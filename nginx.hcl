template {
  source = "/nginx.conf.tpl"
  destination = "/nginx.conf"
  command = "/usr/sbin/nginx -s reload || true"
}