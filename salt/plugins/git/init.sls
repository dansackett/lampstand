{% set common_root_username = salt.pillar.get('common_root_username') %}

Install git:
  pkg.installed:
    - name: git

Set git config:
  git.config_set:
    - name: user.name
    - value: remote_{{ common_root_username }}
    - user: {{ common_root_username }}
    - global: True
