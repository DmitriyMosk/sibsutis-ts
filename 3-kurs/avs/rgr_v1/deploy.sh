#!/bin/bash

set -e

JENKINS_KEYSTORE="jenkins-keystore.jks"
KEYSTORE_PASSWORD="password"
SSL_DIR="ssl"
SSL_CONFIG="ssl.conf"

echo "=== Автоматическая установка Jenkins с HTTPS ==="

if [ ! -f "$SSL_CONFIG" ]; then
  echo "[1/4] Ошибка: Файл $SSL_CONFIG отсутствует!"
  exit 1
fi

source "$SSL_CONFIG"

if [[ -z "$COUNTRY" || -z "$STATE" || -z "$CITY" || -z "$ORGANIZATION" || -z "$ORG_UNIT" || -z "$COMMON_NAME" || -z "$DAYS_VALID" ]]; then
  echo "Ошибка: Один или несколько параметров в $SSL_CONFIG не заданы!"
  exit 1
fi

if [ ! -f "$JENKINS_KEYSTORE" ]; then
  echo "[2/4] Генерация Keystore для Jenkins HTTPS..."
  keytool -genkeypair -alias jenkins -keyalg RSA -keysize 2048 -validity "$DAYS_VALID" \
    -dname "CN=$COMMON_NAME, OU=$ORG_UNIT, O=$ORGANIZATION, L=$CITY, ST=$STATE, C=$COUNTRY" \
    -keystore "$JENKINS_KEYSTORE" -storepass "$KEYSTORE_PASSWORD" -keypass "$KEYSTORE_PASSWORD"
  echo "Keystore создан: $JENKINS_KEYSTORE"
else
  echo "[2/4] Keystore уже существует. Пропускаем..."
fi

if [ ! -d "$SSL_DIR" ]; then
  echo "[3/4] Генерация SSL-сертификатов для Nginx..."
  mkdir -p "$SSL_DIR"
  openssl req -x509 -nodes -days "$DAYS_VALID" -newkey rsa:2048 \
    -keyout "$SSL_DIR/jenkins.key" -out "$SSL_DIR/jenkins.crt" \
    -subj "/C=$COUNTRY/ST=$STATE/L=$CITY/O=$ORGANIZATION/OU=$ORG_UNIT/CN=$COMMON_NAME"
  echo "SSL сертификаты созданы в папке: $SSL_DIR"
else
  echo "[3/4] SSL сертификаты уже существуют. Пропускаем..."
fi

for FILE in "nginx.conf" "ssl.conf" "docker-compose.yml"; do
  if [ ! -f "$FILE" ]; then
    echo "[4/4] Ошибка: Файл $FILE отсутствует!"
    exit 1
  fi
done

echo "[4/4] Запуск контейнеров через Docker Compose..."
docker-compose down
docker-compose up -d

echo "=== Jenkins успешно развернут ==="
echo "Интерфейс Jenkins доступен по HTTPS: https://localhost:443"
