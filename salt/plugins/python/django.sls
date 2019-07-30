Install required Django pips:
  pip.installed:
    - name: virtualenv
    - bin_env: /var/www/.virtualenvs/django_venv
    - require: 
      - virtualenv: /var/www/.virtualenvs/django_venv
