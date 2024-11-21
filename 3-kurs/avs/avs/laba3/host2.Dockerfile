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

RUN useradd -m manager2
RUN echo 'manager2:password2' | chpasswd

RUN ssh-keygen -t rsa -b 4096 -f ~/.ssh/id_ansible

EXPOSE 22

VOLUME ["/root", "/home"]

# Запуск SSH-сервера в фоне
CMD ["/usr/sbin/sshd", "-D"]