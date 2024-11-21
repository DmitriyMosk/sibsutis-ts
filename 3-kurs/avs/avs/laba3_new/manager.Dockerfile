FROM ubuntu:latest

RUN apt-get update && apt-get install -y ssh python3 python3-pip ansible

RUN useradd -m ansible && echo 'ansible:password' | chpasswd
RUN usermod -aG sudo ansible
RUN mkdir /var/run/sshd
RUN echo 'PermitRootLogin yes' >> /etc/ssh/sshd_config

VOLUME [ "/home/ansible/saves" ]

RUN ssh-keygen -A 

USER ansible
WORKDIR /home/ansible

RUN mkdir -p ansible
RUN mkdir -p ansible/inventory ansible/playbooks ansible/roles

COPY ansible.cfg ./ansible 

COPY ./keys/id_rsa ./.ssh/id_rsa
COPY ./keys/id_rsa.pub ./.ssh/id_rsa.pub

USER root 

RUN chmod 600 /home/ansible/.ssh/id_rsa

EXPOSE 22
CMD ["/usr/sbin/sshd", "-D"]