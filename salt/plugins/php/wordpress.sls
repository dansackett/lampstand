Install required Wordpress PHP packages:
  pkg.installed:
    - pkgs:
      - php-curl
      - php-gd
      - php-mbstring
      - php-xml
      - php-xmlrpc
      - php-soap
      - php-intl
      - php-zip
    - require:
      - pkg: php
