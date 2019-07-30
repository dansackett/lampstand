Install virtualenv:
  pip.installed:
    - name: virtualenv
    - bin_env: /usr/bin/pip3
    - require: 
      - pkg: python-pip
      - pkg: python3-pip

Setup Python virtualenv:
  virtualenv.managed:
    - name: /var/www/.virtualenvs/django_venv
    - python: python3
    - system_site_packages: False
    - require:
      - pip: virtualenv
