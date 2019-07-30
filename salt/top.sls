base:
  '*':
    - common
    - security
  'example-minion':
    - bundles.wordpress
    - plugins.letsencrypt
