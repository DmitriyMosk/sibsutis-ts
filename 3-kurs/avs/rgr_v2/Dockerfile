# Dockerfile
FROM jenkins/jenkins:lts

USER root
RUN apt-get update && apt-get install -y python3 python3-pip
RUN groupadd -g 1001 docker-host
RUN usermod -aG docker-host jenkins
USER jenkins