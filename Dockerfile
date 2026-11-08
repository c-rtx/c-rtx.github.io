FROM nginx:alpine-slim

# Configuration Nginx optimisée (gzip, cache statique, headers de sécurité)
COPY nginx.conf /etc/nginx/conf.d/default.conf

# Fichiers du site statique
COPY . /usr/share/nginx/html/

EXPOSE 80

STOPSIGNAL SIGQUIT

CMD ["nginx", "-g", "daemon off;"]
