FROM alpine:3.21
RUN apk update && apk add --no-cache nginx bash vim openssl
RUN mkdir -p /etc/nginx/ssl \
    && openssl req -x509 -nodes -out /etc/nginx/ssl/inception.crt -keyout /etc/nginx/ssl/inception.key \
       -subj "/C=FR/ST=IDF/L=LEHAVRE/0=42/OU=42/CN=tgoudman.42.fr/UID=tgoudman"
RUN mkdir -p /var/run/nginx
COPY conf/nginx.conf /etc/nginx/nginx.conf
EXPOSE 443
CMD ["nginx", "-g", "daemon off;"]
