FROM ubuntu:22.04

RUN apt-get update -y && \  
    apt-get install -y nginx && \
    rm -rf /var/lib/apt/lists/*

# COPY from to
# COPY ./conf/nginx/nginx.conf /etc/nginx/nginx.conf

VOLUME [ "/var/www/html" ]

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]