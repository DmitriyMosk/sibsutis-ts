FROM ubuntu:22.04 

RUN apt-get update && apt-get install -y \
    openssh-server \
    python3 \
    python3-pip && \
    rm -rf /var/lib/apt/lists/*

# Создание необходимой директории
RUN mkdir /var/run/sshd

RUN echo 'root:password' | chpasswd

RUN sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config
RUN sed -i 's/#PasswordAuthentication yes/PasswordAuthentication yes/' /etc/ssh/sshd_config

RUN useradd -m manager1
RUN echo 'manager1:password1' | chpasswd

RUN ssh-keygen -t rsa -b 4096 -f ~/.ssh/id_ansible

EXPOSE 22

COPY ./keys/avs_key.pub authorized_keys

VOLUME ["/root", "/home"]

# Запуск SSH-сервера в фоне
CMD ["/usr/sbin/sshd", "-D"]