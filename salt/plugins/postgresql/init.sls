postgresql:
  pkg.installed:
    - pkgs:
      - libpq-dev
      - postgresql
      - postgresql-contrib

Ensure postgresql service is running:
  service.running:
    - name: postgresql
    - require:
      - pkg: postgresql
    - watch:
      - file: /etc/postgresql/10/main/postgresql.conf
      - file: /etc/postgresql/10/main/pg_hba.conf

Manage postgresql config file:
  file.managed:
    - name: /etc/postgresql/10/main/postgresql.conf
    - source: salt://plugins/postgresql/files/postgresql.conf
    - template: jinja

Manage pg_hba config file:
  file.managed:
    - name: /etc/postgresql/10/main/pg_hba.conf
    - source: salt://plugins/postgresql/files/pg_hba.conf
    - template: jinja
