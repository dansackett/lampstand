# Lampstand

Lampstand is a pluggable Saltstack system which can help deploy application
minions quickly by using predefined bundles. Currently, the bundles supported
are:

- Django
- LAMP Stack
- Wordpress

Each of these bundles is composed of a number of smaller plugins. The plugins
supported currently are:

- Apache
- Django
- Git
- Letsencrypt
- MySQL
- NGINX
- PHP
- Postgresql
- Python
- Wordpress

Basic Linux server security and common server setup is also included.

## Example App

As an example, you can see I have setup `example.com` in this repository. In
order to deploy `example.com` you would edit the `/srv/salt/top.sls` file to
look something like:

```
base:
  '*':
    - common
    - security
  'example-minion':
    - bundles.wordpress
    - plugins.letsencrypt
```

This will setup a WordPress minion with letsencrypt enabled for automatic SSL
certificate renewals via certbot.

In your `/srv/pillar/top.sls` file you would then add the following config:

```
base:
  '*':
    - common
  'example-minion':
    - apps.example.apache
    - apps.example.wordpress
    - apps.example.letsencrypt
```

These pillar files correlate to the pillar data needed for each piece of app
data you will run into. You can see examples of these files in this repository.

## How do I use this?

If you're not familiar with SaltStack then I suggest reading up on it first.
Once you have a solid understanding there you will see that the following repo
simply provides a number of recipes for installing and managing your servers.
These utilities when combined can be quite powerful for orchestration.

I use this setup as the base for my applications online. I maintain a master
server and anytime I need a new server for an application I create a new minion
to that master and simply deploy the recipes I need to make it work.
