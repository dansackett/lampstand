UFW Install:
  pkg:
    - name: ufw
    - latest

UFW Deny default:
  cmd.run:
    - name: ufw default deny
    - unless: "ufw status verbose | grep 'Default: deny (incoming)'"
    - require:
      - pkg: ufw

UFW Enable:
  cmd.run:
    - name: ufw enable
    - onlyif: "ufw status | grep 'Status: inactive'"
    - require:
      - pkg: ufw
