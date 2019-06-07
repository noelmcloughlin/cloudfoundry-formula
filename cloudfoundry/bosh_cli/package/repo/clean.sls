# -*- coding: utf-8 -*-
# vim: ft=sls

{#- Get the `tplroot` from `tpldir` #}
{%- set tplroot = tpldir.split('/')[0] %}
{%- from tplroot ~ "/map.jinja" import cloudfoundry with context %}

    {%- if grains.os_family == 'MacOS' %}

cloudfoundry-bosh_cli-package-repo-install-cmd-run-brew-untap:
  cmd.run:
    - name: /usr/local/bin/brew untap {{ cloudfoundry.bosh_cli.pkg.repo.managed.name }}
    - runas: {{ cloudfoundry.rootuser }}
    - onlyif: /usr/local/bin/brew list | grep {{ cloudfoundry.bosh_cli.pkg.repo.managed.name }} >/dev/null 2>&1

   {%- endif %}
