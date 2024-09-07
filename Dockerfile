FROM rockylinux/rockylinux:8.8

ENV PATH=${PATH}:/root/.local/bin

RUN \
  dnf update -y

RUN \
  dnf install python39 -y

RUN \
  dnf install openssh-clients sshpass -y

RUN \
  python3 -m pip install --user ansible

RUN \
  ansible-galaxy collection install community.docker --force

RUN \
  dnf install vim -y

COPY ./files/opt/bin/loop.sh /opt/bin/loop.sh

CMD ["/opt/bin/loop.sh"]
