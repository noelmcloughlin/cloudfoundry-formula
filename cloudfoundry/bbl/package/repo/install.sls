# -*- coding: utf-8 -*-
# vim: ft=sls

{#- Get the `tplroot` from `tpldir` #}
{%- set tplroot = tpldir.split('/')[0] %}
{%- from tplroot ~ "/map.jinja" import cloudfoundry with context %}

    {%- if cloudfoundry.bbl.pkg.use_upstream_repo and grains.os_family == 'MacOS' %}

cloudfoundry-bbl-package-repo-install-cmd-run-brew-tap:
  cmd.run:
    - name: /usr/local/bin/brew tap {{ cloudfoundry.bbl.pkg.repo.managed.name }}
    - runas: {{ cloudfoundry.rootuser }}

    {%- endif %}
