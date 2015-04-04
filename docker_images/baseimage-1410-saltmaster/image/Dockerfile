FROM phusion/baseimage-1410
RUN rm -f /etc/service/sshd/down
RUN /etc/my_init.d/00_regen_ssh_host_keys.sh
RUN /usr/sbin/enable_insecure_key
RUN add-apt-repository ppa:saltstack/salt && \
    apt-get update && \
    apt-get install -y git && \
    apt-get install -y wget curl salt-minion salt-master salt-api salt-cloud salt-syndic
