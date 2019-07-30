{% set common_root_username = salt.pillar.get('common_root_username') %}
{% set common_root_password = salt.pillar.get('common_root_password') %}
{% set common_root_user_ssh_pub_key = salt.pillar.get('common_root_user_ssh_pub_key') %}

Create common base user:
  user.present:
    - name: {{ common_root_username }}
    - password: {{ common_root_password }}
    - shell: /bin/bash
    - home: /home/{{ common_root_username }}
    - groups:
      - sudo

{{ common_root_user_ssh_pub_key }}:
  ssh_auth.present:
    - user: {{ common_root_username }}
    - enc: ssh-dss
    - require:
      - user: {{ common_root_username }}

Add common user SSH private key:
  file.managed:
    - name: /home/{{ common_root_username }}/.ssh/id_rsa
    - mode: 600
    - source: salt://common/files/id_rsa
    - template: jinja
    
Add common user SSH public key:
  file.managed:
    - name: /home/{{ common_root_username }}/.ssh/id_rsa.pub
    - mode: 644
    - source: salt://common/files/id_rsa.pub
    - template: jinja
