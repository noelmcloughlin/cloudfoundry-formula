# -*- coding: utf-8 -*-
# vim: ft=sls

{#- Get the `tplroot` from `tpldir` #}
{%- set tplroot = tpldir.split('/')[0] %}
{%- from tplroot ~ "/map.jinja" import cloudfoundry with context %}

  {%- if cloudfoundry.cli.pkg.use_upstream_repo %}

include:
  - .repo.clean

  {%- endif %}

cloudfoundry-cli-package-clean-pkg-removed:
  pkg.removed:
    - name: {{ cloudfoundry.cli.pkg.name }}

    {%- if 'deps' in cloudfoundry.cli.pkg and cloudfoundry.cli.pkg.deps %}

cloudfoundry-cli-package-clean-deps-pkg-removed:
  pkg.removed:
    - names: {{ cloudfoundry.cli.pkg.deps }}

    {%- endif %}
