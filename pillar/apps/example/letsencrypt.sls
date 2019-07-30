# -*- coding: utf-8 -*-
# vim: ft=yaml
letsencrypt:
  use_package: true
  pkgs:
    - python-certbot-apache
  config: |
    server = https://acme-v01.api.letsencrypt.org/directory
    email = danesackett@gmail.com
    authenticator = webroot
    webroot-path = /var/www/wordpress
    agree-tos = True
    renew-by-default = True
  config_dir:
    path: /etc/letsencrypt
    user: www-data
    group: www-data
    mode: 755
  domainsets:
    www:
      - example.com
  post_renew:
    cmds:
      - service apache2 reload
  cron:
    minute: 10
    hour: 2
    dayweek: 1
