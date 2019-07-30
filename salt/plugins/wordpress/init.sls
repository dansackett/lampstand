Download Wordpress:
  cmd.run:
    - name: 'wget -q -O - http://wordpress.org/latest.tar.gz | tar zxf - '
    - cwd: /var/www
    - creates: /var/www/wordpress/index.php

Create Wordpress .htaccess:
  file.touch:
    - name: /var/www/wordpress/.htaccess
    - unless: test -f /var/www/wordpress/.htaccess

Manage Wordpress upgrade directory:
  file.directory:
    - name: /var/www/wordpress/wp-content/upgrade

Manage wp-config.php file:
  file.managed:
    - name: /var/www/wordpress/wp-config.php
    - source: salt://plugins/wordpress/files/wp-config.php
    - template: jinja

Manage Wordpress web directory:
  file.directory:
    - name: /var/www/wordpress
    - dir_mode: 750
    - file_mode: 640
    - user: www-data
    - group: www-data
    - recurse:
      - user
      - group
      - mode
