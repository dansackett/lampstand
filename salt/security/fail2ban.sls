fail2ban Install:
  pkg:
    - name: fail2ban
    - latest

Setup fail2ban config:
  file.managed:
    - name: /etc/fail2ban/jail.local
    - source: salt://security/files/jail.local
    - template: jinja
    - require:
      - pkg: fail2ban
