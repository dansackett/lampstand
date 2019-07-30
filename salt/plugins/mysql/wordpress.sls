{% set mysql_database_host = salt.pillar.get('mysql_database_host') %}
{% set mysql_database_name = salt.pillar.get('mysql_database_name') %}
{% set mysql_database_user = salt.pillar.get('mysql_database_user') %}
{% set mysql_database_pass = salt.pillar.get('mysql_database_pass') %}

Add Wordpress MySQL database:
  mysql_database.present:
    - name: {{ mysql_database_name }}
    - require:
      - pkg: mysql-server
      - pkg: python-mysqldb

Add Wordpress MySQL user:
  mysql_user.present:
    - name: {{ mysql_database_user }}
    - password: {{ mysql_database_pass }}
    - host: {{ mysql_database_host }}
    - require:
      - mysql_database: {{ mysql_database_name }}

Add Wordpress MySQL user access grants:
  mysql_grants.present:
    - grant: ALL
    - database: {{ mysql_database_name }}.*
    - user: {{ mysql_database_user }}
    - host: {{ mysql_database_host }}
    - require:
      - mysql_user: {{ mysql_database_user }}
      - mysql_database: {{ mysql_database_name }}
