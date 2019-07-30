Install Apache:
  pkg.installed:
    - name: apache2

UFW Allow Apache Full:
  cmd.run:
    - name: ufw allow in "Apache Full"
    - onlyif: ufw app info "Apache Full"
    - unless: ufw status | grep 'Apache Full\s*ALLOW' # only run if the rule isn't set
    - require:
      - pkg: ufw
      - pkg: apache2

Enable ssl:
  cmd.run:
    - name: sudo a2enmod ssl
    - unless: test -f /etc/apache2/mods-enabled/ssl.load
    - require:
      - pkg: apache2

Ensure common base file exists:
  file.managed:
    - name: /etc/apache2/common_base.conf
    - template: jinja
    - source: salt://plugins/apache/files/sites/common_base.conf

Ensure ssl base file exists:
  file.managed:
    - name: /etc/apache2/ssl.conf
    - template: jinja
    - source: salt://plugins/apache/files/sites/ssl.conf

Ensure apache2.conf exists:
  file.managed:
    - name: /etc/apache2/apache2.conf
    - template: jinja
    - source: salt://plugins/apache/files/apache2.conf

Start Apache:
  service.running:
    - name: apache2
    - enable: True
    - require:
      - file: /etc/apache2/apache2.conf
