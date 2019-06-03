# -*- coding: utf-8 -*-
# vim: ft=sls

{#- Get the `tplroot` from `tpldir` #}
{%- set tplroot = tpldir.split('/')[0] %}
{%- from tplroot ~ "/map.jinja" import cloudfoundry with context %}

    {%-if grains.os_family == 'MacOS' %}

cloudfoundry-cli-package-repo-install-cmd-run-brew-untap:
  cmd.run:
    - name: /usr/local/bin/brew untap {{ cloudfoundry.cli.pkg.repo.managed.name }}
    - runas: {{ cloudfoundry.rootuser }}

    {%- else %}

cloudfoundry-cli-package-repo-clean-pkgrepo-absent:
  pkgrepo.absent:
    - name: {{ cloudfoundry.cli.pkg.repo.name }}

    {%- endif %}
