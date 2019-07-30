Turn off message of the day for SSH:
  file.managed:
    - name: /etc/pam.d/sshd
    - source: salt://security/files/pamd_sshd
    - template: jinja

Setup SSH security banner:
  file.managed:
    - name: /etc/issue.net
    - source: salt://security/files/issue.net
    - template: jinja
