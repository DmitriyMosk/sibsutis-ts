FROM traefik:v2.10

# Установка необходимых пакетов для IPVS
RUN apk add --no-cache ipvsadm iproute2

# Копирование скрипта настройки IPVS
COPY ./conf/traefik/setup-ipvs.sh /usr/local/bin/setup-ipvs.sh
RUN chmod +x /usr/local/bin/setup-ipvs.sh

# Выполнение скрипта настройки IPVS при запуске контейнера
ENTRYPOINT ["/usr/local/bin/setup-ipvs.sh"]
CMD ["traefik"]
