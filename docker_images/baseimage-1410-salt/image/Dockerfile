FROM phusion/baseimage-1410
RUN rm -f /etc/service/sshd/down
RUN /etc/my_init.d/00_regen_ssh_host_keys.sh
RUN /usr/sbin/enable_insecure_key
RUN apt-get update && apt-get install -y wget curl git && rm -rf /var/lib/apt/lists/*
RUN add-apt-repository ppa:saltstack/salt && apt-get update && apt-get install -y salt-minion 
