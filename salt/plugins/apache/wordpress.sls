Enable mod-rewrite:
  cmd.run:
    - name: sudo a2enmod rewrite
    - unless: test -f /etc/apache2/mods-enabled/rewrite.load
    - require:
      - pkg: apache2

Setup Wordpress Apache conf:
  file.managed:
    - name: /etc/apache2/sites-available/wordpress.conf
    - source: salt://plugins/apache/files/sites/wordpress.conf
    - template: jinja
    - require:
      - pkg: apache2

Enabled Wordpress site:
  apache_site.enabled:
    - name: wordpress
    - require:
      - file: /etc/apache2/sites-available/wordpress.conf

Disable default Apache host:
  apache_site.disabled:
    - name: 000-default

Remove default Apache HTML directory:
  file.absent:
    - name: /var/www/html

Watch Apache for wordpress.conf changes:
  service.running:
    - name: apache2
    - enable: True
    - reload: True
    - watch:
      - cmd: sudo a2enmod rewrite
      - file: /etc/apache2/sites-available/wordpress.conf
