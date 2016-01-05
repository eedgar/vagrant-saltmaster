ntpdate_update:
    cmd.run:
        - name: /sbin/ntpdate -b pool.ntp.org
