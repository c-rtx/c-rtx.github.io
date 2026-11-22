FROM nginx:alpine-slim

# Configuration Nginx optimisée (gzip, cache statique, headers de sécurité)
COPY nginx.conf /etc/nginx/conf.d/default.conf

# Fichiers du site statique
COPY . /usr/share/nginx/html/

# Cache-busting automatique des assets CSS à chaque build
RUN CSS_HASH=$(find /usr/share/nginx/html/css -type f | sort | xargs sha256sum | sha256sum | cut -c1-8) && \
    sed -i "s|css/main\.css[^\"]*|css/main.css?v=${CSS_HASH}|g" /usr/share/nginx/html/index.html

EXPOSE 80

STOPSIGNAL SIGQUIT

CMD ["nginx", "-g", "daemon off;"]
