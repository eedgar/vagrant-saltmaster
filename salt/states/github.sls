github.com:
  ssh_known_hosts:
    - present
    - user: root
    - fingerprint: 16:27:ac:a5:76:28:2d:36:63:1b:56:4d:eb:df:a6:48

/root/.ssh/config:
  file.touch

github_salt_config:
   file.blockreplace:
     - name: /root/.ssh/config
     - marker_start: "# ezjail: salt managed github: DO NOT EDIT BY HAND"
     - marker_end: "# ezjail: end of salt managed github --"
     - backup: '.bak'
     - append_if_not_found: True
     - content: |
           Host github.com
                IdentityFile /root/.ssh/github-saltmaster-rsa
     - show_changes: True
