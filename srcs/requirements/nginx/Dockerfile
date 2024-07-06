FROM alpine:3.16

RUN apk update && apk add nginx openssl

RUN mkdir -p /var/www/html /etc/nginx/ssl /run/nginx

COPY conf/nginx.conf /etc/nginx/http.d/default.conf

# nginx ssl
RUN mkdir -p /etc/nginx/ssl
RUN openssl req -newkey rsa:4096 -x509 -sha256 -days 365 -nodes \
        -out /etc/nginx/ssl/sslcert.crt \
        -keyout /etc/nginx/ssl/sslcert.key \
        -subj "/C=CA/ST=Quebec/L=Quebec City/O=42School/OU=42Quebec/CN=alpicard.42.fr"

# start nginx
CMD [ "nginx", "-g", "daemon off;" ]
