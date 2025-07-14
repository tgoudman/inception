FROM alpine:3.18
RUN apk update && apk add --no-cache nginx
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]