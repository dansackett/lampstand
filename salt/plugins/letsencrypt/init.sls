{% from "plugins/letsencrypt/map.jinja" import letsencrypt with context %}

{% set check_cert_cmd = '/usr/bin/certbot renew --dry-run --cert-name' %}
{% set renew_cert_cmd = '/usr/bin/certbot renew' %}
{% set old_check_cert_cmd_state = 'absent' %}
{% set old_renew_cert_cmd_state = 'absent' %}
{% set old_cron_state = 'absent' %}
{% set create_cert_cmd = '/usr/bin/certbot' %}

letsencrypt-client:
  pkg.installed:
    - pkgs: {{ letsencrypt.pkgs }}

letsencrypt-config-directory:
  file.directory:
    - name: {{ letsencrypt.config_dir.path }}
    - user: {{ letsencrypt.config_dir.user }}
    - group: {{ letsencrypt.config_dir.group }}
    - dir_mode: {{ letsencrypt.config_dir.mode }}
letsencrypt-config:
  file.managed:
    - name: {{ letsencrypt.config_dir.path }}/cli.ini
    - user: {{ letsencrypt.config_dir.user }}
    - group: {{ letsencrypt.config_dir.group }}
    - makedirs: true
    - contents_pillar: letsencrypt:config

{{ check_cert_cmd }}:
  file.{{ old_check_cert_cmd_state }}:
    - template: jinja
    - source: salt://letsencrypt/files/check_letsencrypt_cert.sh.jinja
    - mode: 755
{{ renew_cert_cmd }}:
  file.{{ old_renew_cert_cmd_state }}:
    - template: jinja
    - source: salt://letsencrypt/files/renew_letsencrypt_cert.sh.jinja
    - mode: 755
    - require:
      - file: {{ check_cert_cmd }}
{% for setname, domainlist in letsencrypt.domainsets.items() %}
# domainlist[0] represents the "CommonName", and the rest
# represent SubjectAlternativeNames
create-initial-cert-{{ setname }}-{{ domainlist | join('+') }}:
  cmd.run:
    - unless: {{ check_cert_cmd }} {{ domainlist[0] }}
    - name: {{ create_cert_cmd }} certonly --quiet -d {{ domainlist|join(' -d ') }} --non-interactive
      {% if not letsencrypt.use_package %}
    - cwd: {{ letsencrypt.cli_install_dir }}
      {% endif %}
    - require:
      {% if letsencrypt.use_package %}
      - pkg: letsencrypt-client
      {% else %}
      - file: {{ check_cert_cmd }}
      {% endif %}
      - file: letsencrypt-config
letsencrypt-crontab-{{ setname }}-{{ domainlist[0] }}:
  cron.{{ old_cron_state }}:
    - name: {{ renew_cert_cmd }} {{ domainlist|join(' ') }}
    - month: '*'
    - minute: '{{ letsencrypt.cron.minute }}'
    - hour: '{{ letsencrypt.cron.hour }}'
    - dayweek: '{{ letsencrypt.cron.dayweek }}'
    - identifier: letsencrypt-{{ setname }}-{{ domainlist[0] }}
    - require:
      - cmd: create-initial-cert-{{ setname }}-{{ domainlist | join('+') }}
      {% if letsencrypt.use_package %}
      - pkg: letsencrypt-client
      {% else %}
      - file: {{ renew_cert_cmd }}
      {% endif %}
create-fullchain-privkey-pem-for-{{ domainlist[0] }}:
  cmd.run:
    - name: |
        cat {{ letsencrypt.config_dir.path }}/live/{{ domainlist[0] }}/fullchain.pem \
            {{ letsencrypt.config_dir.path }}/live/{{ domainlist[0] }}/privkey.pem \
            > {{ letsencrypt.config_dir.path }}/live/{{ domainlist[0] }}/fullchain-privkey.pem && \
        chmod 600 {{ letsencrypt.config_dir.path }}/live/{{ domainlist[0] }}/fullchain-privkey.pem
    - creates: {{ letsencrypt.config_dir.path }}/live/{{ domainlist[0] }}/fullchain-privkey.pem
    - require:
      - cmd: create-initial-cert-{{ setname }}-{{ domainlist | join('+') }}
{% endfor %}

letsencrypt-service-timer:
  service.running:
    - name: {{ letsencrypt.service }}
    - enable: true
    - watch:
      - pkg: letsencrypt-client
