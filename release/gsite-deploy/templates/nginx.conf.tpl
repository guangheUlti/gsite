# ===========================================================================
# nginx configuration of the GSite deploy package
# generated from templates\nginx.conf.tpl by gsite.ps1 - edit config.bat instead
#
#   browser --> nginx (WEB_PORT)
#                 /            : static front-end (html\)
#                 /admin-api/  : reverse proxy to the Spring Boot backend
#                 /infra/ws    : WebSocket, same backend
#   The backend, MySQL and Redis bind to 127.0.0.1, so nothing but WEB_PORT is
#   reachable from the network.
# ===========================================================================

worker_processes  auto;
error_log  logs/error.log  warn;
pid        logs/nginx.pid;

events {
    worker_connections  4096;
}

http {
    include       mime.types;
    default_type  application/octet-stream;

    log_format  main  '$remote_addr - $remote_user [$time_local] "$request" '
                      '$status $body_bytes_sent "$http_referer" '
                      '"$http_user_agent" "$http_x_forwarded_for" rt=$request_time';
    access_log  logs/access.log  main;

    sendfile        on;
    tcp_nopush      on;
    keepalive_timeout  65;
    server_tokens   off;

    # uploaded attachments go through nginx, keep the ceiling above the backend limit
    client_max_body_size  200m;

    gzip  on;
    gzip_min_length  1k;
    gzip_comp_level  5;
    gzip_types  text/plain text/css application/javascript application/json
                application/xml image/svg+xml application/x-font-ttf font/opentype;
    gzip_vary   on;

    # WebSocket upgrade needs "Connection: upgrade" only when the client asked for it
    map $http_upgrade $connection_upgrade {
        default upgrade;
        ''      close;
    }

    upstream gsite_backend {
        server 127.0.0.1:@BACKEND_PORT@;
        keepalive  64;
    }

    server {
        listen       @WEB_PORT@;
        server_name  _;

        root  "@WEB_ROOT@";
        index index.html;

        # ---- front-end (history router: unknown paths fall back to index.html) ----
        location / {
            try_files $uri $uri/ /index.html;
        }
        # the entry point must always be revalidated: a new build deletes the old
        # hashed bundles, so a cached index.html would reference files that are gone
        # (white screen). Covers the deep-link fallback of the history router too.
        location = /index.html {
            add_header Cache-Control "no-cache";
        }
        # hashed bundles can be cached hard
        location ~* ^/assets/ {
            expires 30d;
            access_log off;
            add_header Cache-Control "public";
            try_files $uri =404;
        }
        # never serve dot files
        location ~ /\. {
            deny all;
        }

        # ---- backend API ----
        location /admin-api/ {
            proxy_pass       http://gsite_backend;
            proxy_http_version 1.1;
            proxy_set_header Host              $host;
            proxy_set_header X-Real-IP         $remote_addr;
            proxy_set_header X-Forwarded-For   $proxy_add_x_forwarded_for;
            proxy_set_header X-Forwarded-Proto $scheme;
            proxy_connect_timeout 30s;
            proxy_send_timeout    600s;
            proxy_read_timeout    600s;
        }

        # ---- WebSocket (the front-end connects to /infra/ws?token=...) ----
        location = /infra/ws {
            proxy_pass       http://gsite_backend;
            proxy_http_version 1.1;
            proxy_set_header Upgrade    $http_upgrade;
            proxy_set_header Connection $connection_upgrade;
            proxy_set_header Host       $host;
            proxy_set_header X-Real-IP  $remote_addr;
            proxy_read_timeout 3600s;
            proxy_send_timeout 3600s;
        }

        # ---- optional: expose the backend consoles through nginx ----
        # The backend itself listens on 127.0.0.1, so on the server you can always
        # open http://127.0.0.1:@BACKEND_PORT@/admin (Spring Boot Admin) and
        # http://127.0.0.1:@BACKEND_PORT@/druid. Uncomment to reach them remotely,
        # ideally together with an "allow"/"deny" IP whitelist.
        #
        #location /admin/ {
        #    allow 127.0.0.1;
        #    deny  all;
        #    proxy_pass http://gsite_backend;
        #    proxy_set_header Host $host;
        #    proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
        #}
        #location /druid/ {
        #    allow 127.0.0.1;
        #    deny  all;
        #    proxy_pass http://gsite_backend;
        #    proxy_set_header Host $host;
        #}
    }
}
