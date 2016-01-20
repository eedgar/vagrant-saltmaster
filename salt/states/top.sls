base:
 '*':
   - salt.minion

 'role:saltmaster':
   - match: grain
   - ntp
   - time_init
   - git
   - pip
   - salt.gitfs.gitpython
   - salt.formulas
   - salt.pillars
   - users
   - github
   - bitbucket
   - salt.master
