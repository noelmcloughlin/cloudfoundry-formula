# -*- coding: utf-8 -*-
# vim: ft=sls

{#- Get the `tplroot` from `tpldir` #}
{%- set tplroot = tpldir.split('/')[0] %}
{%- from tplroot ~ "/map.jinja" import cloudfoundry with context %}

  {%- if cloudfoundry.cli.pkg.use_upstream_repo %}
      {%- from tplroot ~ "/jinja/macros.jinja" import format_kwargs with context %}

cloudfoundry-cli-package-repo-install-brew-tap:
  cmd.run:
    - name: brew tap {{ cloudfoundry.cli.pkg.repo.managed.name }}
    - onlyif: {{ grains.os_family == 'MacOS' }}

cloudfoundry-cli-package-repo-install-pkgrepo-managed:
  pkgrepo.managed:
    {{- format_kwargs(cloudfoundry.cli.pkg.repo.managed) }}
    - unless: {{ grains.os_family == 'MacOS' }}

  {%- endif %}
