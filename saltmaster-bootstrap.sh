#!/bin/sh

if [ -f '/var/.bootstrapped' ]
then
    echo "The system has already been bootstrapped."
else


OS_TYPE=$(uname -s)
if [ "${OS_TYPE}" = 'Linux' ]; then
    # install salt client
    if [ ! -x '/usr/bin/salt-call' ];
    then
        ntpdate -b pool.ntp.org
        wget -O install_salt.sh https://bootstrap.saltstack.com
        sudo sh install_salt.sh
    fi
elif [ "${OS_TYPE}" = 'FreeBSD' ]; then
    if [ ! -x '/usr/local/bin/salt' ]; then
        ntpdate -b pool.ntp.org
        fetch -o /tmp/salt_bootstrap.sh http://bootstrap.saltstack.org
        chmod +x /tmp/salt_bootstrap.sh
    fi
fi

mkdir -p /root/.ssh
cat << EOF > /root/.ssh/id_rsa
-----BEGIN RSA PRIVATE KEY-----
MIIEpQIBAAKCAQEAu7QSJildxEULtXfuveVcNFVAR/LWINUr7PDgmeEhKBls8/jp
9KUwyiAaTTYgww+Ol3zAZAdajCkfi2QZZAkG58dJ2TIz8fL4TYZPDz6dU11E1YS2
bH9ZKRRcuWIptfrRNK6TqYuXQFH/wUXYDG7d60ZA+awKoVRZU/Rp1bdi7dPvnhMN
I6WWDDc6xZD/7/2qYLzCC7NrHXsQ0Ibg1nPaQkYZpETMJ+Ap1vT/hGou/9VJ1Xqd
YxVsnsRyzT5mB1SOjHl1JxcHeO+huiCfYzkOay/A1c6MPTAya6pq86kz7wxO4wKO
0RsSKCtBbJRG1GEu3r04byAGGUFY3leN4Oq44wIDAQABAoIBAQCnTuqeeWDLAYBe
UHjNaxO00ghqGVokCd8NY+fPQYx8Ya1sCgL/vf6vK85F5GlvdP50qQ4UGznqlP05
EhBPynwNPOXmY4lJsHkDISR3QiiZlhk0+QZhz2F57Fx6IbVsMBUqEDIufe5jtrNx
YwAglPHaNNTVtzQCeVzmKIXtqXjU4v10xMscSiDEEMQvnC0+4fius9i4TYAs2Nmz
cwswUHEnCFZNb2pjOMon+4ysVMDtUGY5b/Wee5cr4OAhNjIR6xuy8ba7tijBNdpe
2j6uz24LMnlBBEDpp6leT0X6DhNcKFAvrwjXvEvYQFYn7g/k4I77T4Qhu2Ni0UI1
07umg/2BAoGBAN1oG+laU05nxRzdyiICNTS8sWxZiRf4Bg1U08hjp9KrkBJ89yJr
3bcXCCMsboBYh9H0YYDwDfsXZdONI8nRAamAtz1wLjdLxP18aV09bqw+M6X9iawT
GO6KyQA8svPVP0ymM1SN/FClA8wQoDrHhH39IeWSiDVDKisg6a+PX7bdAoGBANkH
4136u0JSQtI/JFkB1xS8LhSkvt4BGLW9Ijz3DupjEBIjAEnxJRkQ0O714dIfwlbP
iqLNQ+4qW7HSjWDtV/QhOd3DwS1UpiNqApNf2zm9xpXi3iUHfDi0G4aUqBSVOiDG
Gn8oheIq0o2DezMpv6UwkODqMq76LkumMbNugNK/AoGBAJjRyiooGUYN5ATHpUQS
CA1tjHz/09uCaxL6kO9IscZ8eoX4UVAl6bP9JrW4blESSjUFm+M2TkAYZ0U8rw4W
wDHx0QiMDKpIFyDrpYIg6+nhSR7yP/tQdy33B0OtocshTn6mXNmo4xX6wAMzGpVX
r0CS3rmpiXBR+qIoJoPxzxvVAoGBAMkcsCrUP1aT1+vwKwR32hES2Di0+VHL/lPa
8bFA14eHSMsluAzM8y2pEZN+MkZ+u52qMLPwNnSqt9GuZOhex9QoPfEshwQ0nsfO
YpiiiQmWvEEEvAngR9Jbw+4QLzjzl6vrJ36R1I7iU75jCnU8yKSQvpBNNa5Dk0by
uLenPKUNAoGAZ494EH0jwSRCovXLXnGzYwMxuLjNRblgiwPjA5q9QeTIFpXpDFT1
hvGq2XfHFTHHJdRG8aC7orVZnlGPlsSG/hQrwf9X6n/oIFlYIBxbsjaaWZjapalL
4hyoXyqjQiSLmbuc1EJlQjsejI9QGMx9HhvEv/8OAFptcX7cWKuM9a8=
-----END RSA PRIVATE KEY-----
EOF
chmod 600 /root/.ssh/id_rsa
chown root /root/.ssh/id_rsa

cat << EOF > /root/.ssh/id_rsa.pub
ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQC7tBImKV3ERQu1d+695Vw0VUBH8tYg1Svs8OCZ4SEoGWzz+On0pTDKIBpNNiDDD46XfMBkB1qMKR+LZBlkCQbnx0nZMjPx8vhNhk8PPp1TXUTVhLZsf1kpFFy5Yim1+tE0rpOpi5dAUf/BRdgMbt3rRkD5rAqhVFlT9GnVt2Lt0++eEw0jpZYMNzrFkP/v/apgvMILs2sdexDQhuDWc9pCRhmkRMwn4CnW9P+Eai7/1UnVep1jFWyexHLNPmYHVI6MeXUnFwd476G6IJ9jOQ5rL8DVzow9MDJrqmrzqTPvDE7jAo7RGxIoK0FslEbUYS7evThvIAYZQVjeV43g6rjj eedgar@i7
EOF

chmod 755 /root/.ssh/id_rsa.pub
chown root /root/.ssh/id_rsa

# enas, bitbucket
cat << EOF > /root/.ssh/known_hosts
enas.familyds.com ecdsa-sha2-nistp256 AAAAE2VjZHNhLXNoYTItbmlzdHAyNTYAAAAIbmlzdHAyNTYAAABBBFkbPMzkp90Qtqoz45mV9zbtmJLemeHRmBcIAL+0HmCJ9hC71xrTvXaAgZ68lsByU9L8FiBXyoCAz383pdUdtaY=
|1|vCwFnn98DOnYRM1SD/rEqzIMNY0=|Ashm1BOOd9qgjrFZMdkkWsAZl1Y= ssh-rsa AAAAB3NzaC1yc2EAAAABIwAAAQEAubiN81eDcafrgMeLzaFPsw2kNvEcqTKl/VqLat/MaB33pZy0y3rJZtnqwR2qOOvbwKZYKiEO1O6VqNEBxKvJJelCq0dTXWT5pbO2gDXC6h6QDXCaHo6pOHGPUy+YBaGQRGuSusMEASYiWunYN0vCAI8QaXnWMXNMdFP3jHAJH0eDsoiGnLPBlBp4TNm6rYI74nMzgz3B9IikW4WVK+dc8KZJZWYjAuORU3jc1c/NPskD2ASinf8v3xnfXeukU0sJ5N6m5E8VLjObPEO+mN2t/FZTMZLiFqPWc/ALSqnMnnhwrNi2rbfg/rd/IpL8Le3pSBne8+seeFVBoGqzHM9yXw==
|1|FGoySCvHEIlbMnsOGVSA6M5R5pY=|NqCcprSxR01jScPuSjONt3f+uPo= ssh-rsa AAAAB3NzaC1yc2EAAAABIwAAAQEAubiN81eDcafrgMeLzaFPsw2kNvEcqTKl/VqLat/MaB33pZy0y3rJZtnqwR2qOOvbwKZYKiEO1O6VqNEBxKvJJelCq0dTXWT5pbO2gDXC6h6QDXCaHo6pOHGPUy+YBaGQRGuSusMEASYiWunYN0vCAI8QaXnWMXNMdFP3jHAJH0eDsoiGnLPBlBp4TNm6rYI74nMzgz3B9IikW4WVK+dc8KZJZWYjAuORU3jc1c/NPskD2ASinf8v3xnfXeukU0sJ5N6m5E8VLjObPEO+mN2t/FZTMZLiFqPWc/ALSqnMnnhwrNi2rbfg/rd/IpL8Le3pSBne8+seeFVBoGqzHM9yXw==
EOF
chmod 755 /root/.ssh/known_hosts
chown root /root/.ssh/known_hosts

# Clone the initial repos

if [ -d /root/conf ];
then
  rm -rf /root/conf
fi
mkdir -p /root/conf/pillar

apt-get install -y git

(cd /root/conf/pillar; git clone git@bitbucket.org:eedgar/salt_pillar.git .)
(cd /root/conf; git clone git@bitbucket.org:eedgar/salt_master.git)
(cd /root/conf; git clone https://github.com/eedgar/salt-formula.git)

echo `hostname -f` /etc/salt/minion_id

cat << EOF > /root/conf/minion
file_client: local

pillar_roots:
  base:
    - /root/conf/pillar

file_roots:
  base:
    - /root/conf
    - /root/conf/salt-formula
    - /root/conf/rephunter-saltmaster-dev
EOF

cat << EOF > /root/conf/top.sls
base:
   '*':
      - salt_default_master
      - salt.gitfs.gitpython
      - salt.formulas
      - salt.yubiauth
      - salt.master
      - salt.minion
EOF

cat << EOF > /root/conf/salt_default_master.sls
git_pkgs:
   pkg.installed:
      - pkgs:
        - git

/etc/salt:
    file.directory:
        - user: root
        - mode: 755
        - makedirs: True
EOF

salt-call -c /root/conf --local state.highstate  || exit 1

sleep 15
salt-key -y -a `hostname`
#rm -r /root/conf
touch /var/.bootstrapped
fi

echo "Running salt.master state"
salt-run fileserver.update
salt-call state.sls salt.master
