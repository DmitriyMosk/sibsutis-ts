FROM ubuntu:latest

RUN apt-get update && apt-get install -y ssh python3 python3-pip

RUN useradd -m ansible && echo 'ansible:password' | chpasswd
RUN usermod -aG sudo ansible
RUN mkdir -p /var/run/sshd
RUN echo 'PermitRootLogin yes' >> /etc/ssh/sshd_config

VOLUME [ "/home/ansible/saves" ]

RUN ssh-keygen -A 

COPY ./keys/id_rsa.pub /home/ansible/.ssh/id_rsa.pub
RUN cat /home/ansible/.ssh/id_rsa.pub >> /home/ansible/.ssh/authorized_keys

WORKDIR /home/ansible

USER root
EXPOSE 22
CMD ["/usr/sbin/sshd", "-D"]
