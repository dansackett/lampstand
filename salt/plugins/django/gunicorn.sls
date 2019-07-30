Create Gunicorn socket file:
  file.managed:
    - name: /etc/systemd/system/gunicorn.socket
    - source: salt://plugins/django/files/gunicorn.socket
    - template: jinja

Create Gunicorn service file:
  file.managed:
    - name: /etc/systemd/system/gunicorn.service
    - source: salt://plugins/django/files/gunicorn.service
    - template: jinja

Run gunicorn service:
  service.running:
    - name: gunicorn
    - watch:
      - file: /etc/systemd/system/gunicorn.socket
      - file: /etc/systemd/system/gunicorn.service
