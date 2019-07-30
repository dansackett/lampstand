{% set github_repo_address = salt.pillar.get('github_repo_address') %}
{% set common_root_username = salt.pillar.get('common_root_username') %}

Install required Django pips:
  pip.installed:
    - requirements: salt://plugins/django/files/base_requirements.txt
    - bin_env: /var/www/.virtualenvs/django_venv
    - require: 
      - virtualenv: /var/www/.virtualenvs/django_venv

Manage Django web directory:
  file.directory:
    - name: /var/www/django
    - user: www-data
    - group: www-data
    - recurse:
      - user
      - group

Manage Django git repository:
  git.latest:
    - name: {{ github_repo_address }}
    - target: /var/www/django/
    - identity: /home/{{ common_root_username }}/.ssh/id_rsa
    - onlyif: test -f /home/{{ common_root_username }}/.ssh/id_rsa
    - require:
      - file: /var/www/django

Manage local settings:
  file.managed:
    - name: /var/www/django/settings/local.py
    - source: salt://plugins/django/files/local_settings.py
    - template: jinja
    - require:
      - git: {{ github_repo_address }}

Run migrations:
  cmd.run:
    - name: /var/www/.virtualenvs/django_venv/bin/python3 manage.py migrate
    - cwd: /var/www/django
    - require:
      - git: {{ github_repo_address }}

Collect static files:
  cmd.run:
    - name: /var/www/.virtualenvs/django_venv/bin/python3 manage.py collectstatic --noinput
    - cwd: /var/www/django
    - require:
      - git: {{ github_repo_address }}

UFW Allow Django port:
  cmd.run:
    - name: ufw allow in "Nginx Full"
    - onlyif: ufw app info "Nginx Full"
    - unless: ufw status | grep 'Nginx Full\s*ALLOW' # only run if the rule isn't set
    - require:
      - pkg: ufw
      - pkg: nginx
