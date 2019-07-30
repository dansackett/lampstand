{% set postgres_database_name = salt.pillar.get('postgres_database_name') %}
{% set postgres_database_user = salt.pillar.get('postgres_database_user') %}
{% set postgres_database_pass = salt.pillar.get('postgres_database_pass') %}

Create postgres database_user:
  postgres_user.present:
    - name: {{ postgres_database_user }}
    - password: {{ postgres_database_pass }}
    - login: True
    - require:
      - pkg: postgresql

Create postgres database:
  postgres_database.present:
    - name: {{ postgres_database_name }}
    - owner: {{ postgres_database_user }}
    - encoding: 'utf8'
    - require:
      - pkg: postgresql
      - postgres_user: {{ postgres_database_user }}
