#!/bin/sh 

mkdir ssl && cd ssl
openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
    -keyout jenkins.key -out jenkins.crt \
    -subj "/C=RU/ST=Russia/L=Novosibirsk/O=SibsutisAVS/OU=Unit/CN=localhost"
cd ..
