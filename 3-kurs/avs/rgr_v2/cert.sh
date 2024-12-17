#!/bin/sh

openssl req -newkey rsa:2048 -nodes -keyout ./certs/jenkins.key -x509 -days 365 -subj "/C=RU/ST=Novisibirsk/L=Sibgachi/O=SibgachiCrypto/OU=AndreevINC/CN=ggwpTMOVSOSMSSOAPYSDR" -out ./certs/jenkins.crt

# 44123e7f90e74627aa77d42bb67ee237
# ac8b1b5381474ce5bce0b4efc6e0076e
# 4b0a8c8350d344cd88ec32123c7e9802