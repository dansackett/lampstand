base:
  '*':
    - common
  'example-minion':
    - apps.example.apache
    - apps.example.wordpress
    - apps.example.letsencrypt
