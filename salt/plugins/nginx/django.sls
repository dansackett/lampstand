Create Nginx Django site file:
  file.managed:
    - name: /etc/nginx/sites-available/django
    - source: salt://plugins/nginx/files/django_conf
    - template: jinja

Enable Nginx site:
  cmd.run:
    - name: ln -s /etc/nginx/sites-available/django /etc/nginx/sites-enabled
    - unless: test -f /etc/nginx/sites-enabled/django

Disable default Nginx site:
  file.absent:
    - name: /etc/nginx/sites-enabled/default

Watch Nginx config and run service:
  service.running:
    - name: nginx
    - enable: True
    - watch:
      - file: /etc/nginx/sites-available/django
