FROM alpine:3.18
RUN apk update && apk add --no-cache nginx
RUN apk add vim
RUN mkdir -p /etc/nginx/ssl
RUN apk add openssl
RUN oppenssl req -x509 -nodes -out /etc/nginx/ssl/inception.crt -keyout /etc/nginx/ssl/inception.key -subj "/C=FR/ST=IDF/L=Paris/0=42/OU=42/CN=login.42.fr/UID=login"
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]