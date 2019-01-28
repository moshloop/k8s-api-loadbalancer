global
  maxconn 512

defaults
  mode tcp
  timeout connect 5s
  timeout client 120s
  timeout server 120s

frontend kubernetes
  bind localhost:{{ env "PORT" }}
  default_backend k8s-api

backend k8s-api
  balance roundrobin
  option tcp-check
  {{ range env "SERVICE_NAME" | service}}
  server {{.ID}} {{ .Address }}:{{ .Port }}
  {{ end }}

listen  stats
  bind 0.0.0.0:1936
  mode            http
  log             global

  maxconn 10
  timeout connect 100s
  timeout client  100s
  timeout server  100s
  timeout queue   100s
  stats enable
  stats hide-version
  stats refresh 30s
  stats show-node
  stats auth admin:password
  stats uri  /