{% set django_secret_key = salt.pillar.get('django_secret_key') %}

{% set postgres_database_name = salt.pillar.get('postgres_database_name') %}
{% set postgres_database_user = salt.pillar.get('postgres_database_user') %}
{% set postgres_database_pass = salt.pillar.get('postgres_database_pass') %}
{% set postgres_database_host = salt.pillar.get('postgres_database_host') %}
{% set postgres_database_port = salt.pillar.get('postgres_database_port') %}

{% set django_allowed_hosts = salt.pillar.get('django_allowed_hosts') %}

"""
Local Django settings.
"""

from settings.common import *

SECRET_KEY = '{{ django_secret_key }}'
DEBUG = True
ALLOWED_HOSTS = [{% for allowed_host in django_allowed_hosts %}'{{ allowed_host }}',{% endfor %}]

DATABASES = {
    'default': {
        'ENGINE': 'django.db.backends.postgresql',
        'NAME': '{{ postgres_database_name }}',
        'USER': '{{ postgres_database_user }}',
        'PASSWORD': '{{ postgres_database_pass }}',
        'HOST': '{{ postgres_database_host }}',
        'PORT': '{{ postgres_database_port }}',
    }
}
