user_keydir_bitbucket_root:
  file.directory:
    - name: /root/.ssh
    - user: root
    - group: root
    - makedirs: True
    - mode: 700

bitbucket.org:
  ssh_known_hosts:
    - present
    - user: root
    - key: AAAAB3NzaC1yc2EAAAABIwAAAQEAubiN81eDcafrgMeLzaFPsw2kNvEcqTKl/VqLat/MaB33pZy0y3rJZtnqwR2qOOvbwKZYKiEO1O6VqNEBxKvJJelCq0dTXWT5pbO2gDXC6h6QDXCaHo6pOHGPUy+YBaGQRGuSusMEASYiWunYN0vCAI8QaXnWMXNMdFP3jHAJH0eDsoiGnLPBlBp4TNm6rYI74nMzgz3B9IikW4WVK+dc8KZJZWYjAuORU3jc1c/NPskD2ASinf8v3xnfXeukU0sJ5N6m5E8VLjObPEO+mN2t/FZTMZLiFqPWc/ALSqnMnnhwrNi2rbfg/rd/IpL8Le3pSBne8+seeFVBoGqzHM9yXw==

user_root_bitbucket_bootstrap_private_key:
  file.managed:
    - name: /root/.ssh/bitbucket-saltmaster-rsa
    - source: salt://bitbucket/files/bitbucket-bootstrap-rsa
    - user: root
    - group: root
    - mode: 600
    - show_diff: False
    - require:
      - file: user_keydir_bitbucket_root

user_root_bitbucket_bootstrap_pub_key:
  file.managed:
    - name: /root/.ssh/bitbucket-saltmaster-rsa.pub
    - source: salt://bitbucket/files/bitbucket-bootstrap-rsa.pub
    - user: root
    - group: root
    - mode: 600
    - show_diff: False
    - require:
      - file: user_keydir_bitbucket_root

bitbucket_salt_config:
   file.blockreplace:
     - name: /root/.ssh/config
     - marker_start: "# ezjail: salt managed bitbucket: DO NOT EDIT BY HAND"
     - marker_end: "# ezjail: end of salt managed bitbucket --"
     - backup: '.bak'
     - append_if_not_found: True
     - content: |
           Host bitbucket.org
               IdentityFile /root/.ssh/bitbucket-saltmaster-rsa
     - show_changes: True
