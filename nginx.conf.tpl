load_module /usr/lib/nginx/modules/ngx_stream_module.so;
events {
    worker_connections  1024;
}

stream {

upstream stream_backend {

    {{ range env "SERVICE_NAME" | service}}
    server  {{ .Address }}:{{ .Port }};
    {{ end }}
    server localhost:{{ env "PORT"}} down;
}

server {
    listen     {{ env "PORT" }};
    proxy_pass stream_backend;
}

}