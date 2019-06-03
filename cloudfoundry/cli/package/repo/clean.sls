# -*- coding: utf-8 -*-
# vim: ft=sls

{#- Get the `tplroot` from `tpldir` #}
{%- set tplroot = tpldir.split('/')[0] %}
{%- from tplroot ~ "/map.jinja" import cloudfoundry with context %}

cloudfoundry-cli-package-repo-install-brew-tap:
  cmd.run:
    - name: brew untap {{ cloudfoundry.cli.pkg.repo.managed.name }}
    - onlyif: {{ grains.os_family == 'MacOS' }}

cloudfoundry-cli-package-repo-clean-pkgrepo-absent:
  pkgrepo.absent:
    - name: {{ cloudfoundry.cli.pkg.repo.name }}
    - unless: {{ grains.os_family == 'MacOS' }}
