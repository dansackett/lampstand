Install PHP MySQL:
  pkg.installed:
    - name: php-mysql
    - require:
      - pkg: php
      - pkg: mysql-server
