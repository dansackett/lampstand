Install Apache Mod PHP:
  pkg.installed:
    - name: libapache2-mod-php
    - require:
      - pkg: php
      - pkg: apache2

Update Apache mods-enabled dir.conf:
  file.managed:
    - name: /etc/apache2/mods-enabled/dir.conf
    - source: salt://plugins/apache/files/mods/dir.conf
    - template: jinja
    - require:
      - pkg: apache2

Watch Apache for dir.conf changes:
  service.running:
    - name: apache2
    - enable: True
    - reload: True
    - watch:
      - file: /etc/apache2/mods-enabled/dir.conf
