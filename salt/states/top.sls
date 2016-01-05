base:
 '*':
   - salt.minion

 'role:saltmaster':
   - match: grain
   - ntp
   - time_init
   - salt.gitfs.gitpython
   - salt.formulas
   - users
   - github
   - bitbucket
   - salt.master
