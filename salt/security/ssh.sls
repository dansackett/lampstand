{% set common_root_username = salt.pillar.get('common_root_username') %}

UFW Allow OpenSSH:
  cmd.run:
    - name: ufw allow OpenSSH
    - unless: ufw status | grep "OpenSSH\s*ALLOW" # only run if the rule isn't set
    - require:
      - pkg: ufw

Setup SSH config file:
  file.managed:
    - name: /etc/ssh/sshd_config
    - source: salt://security/files/sshd_config
    - template: jinja
    - require:
      - file: /etc/issue.net

Start SSH:
  service.running:
    - name: ssh
    - enable: True
    - watch:
      - file: /etc/issue.net
