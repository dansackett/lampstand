# Required for database management via Salt
Install python-mysqldb:
  pkg.installed:
    - name: python-mysqldb

Install mysql-server:
  pkg.installed:
    - name: mysql-server
    - require:
      - pkg: python-mysqldb

Ensure MySQL config exists:
  file.managed:
    - name: /etc/mysql/my.cnf
    - source: salt://plugins/mysql/files/my.cnf
    - template: jinja
    - require:
      - pkg: mysql-server

Start MySQL:
  service.running:
    - name: mysql
    - watch:
      - pkg: mysql-server
      - file: /etc/mysql/my.cnf

{% if salt['grains.get']('mysql_secure_installation') != 'done' %}

Run MySQL secure installation script:
  cmd.script:
    - name: salt://mysql/files/mysql_secure_installation.sh
    - require:
      - pkg: mysql-server
      - service: mysql
  grains.present:
    - name: mysql_secure_installation
    - value: 'done'

{% endif %}
