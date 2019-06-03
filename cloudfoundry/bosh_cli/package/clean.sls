# -*- coding: utf-8 -*-
# vim: ft=sls

{#- Get the `tplroot` from `tpldir` #}
{%- set tplroot = tpldir.split('/')[0] %}
{%- from tplroot ~ "/map.jinja" import cloudfoundry with context %}

  {%- if cloudfoundry.bosh_cli.pkg.use_upstream_repo %}
include:
  - .repo.clean

  {%- endif %}
  {%- if 'name' in cloudfoundry.bosh_cli.pkg and cloudfoundry.bosh_cli.pkg.name %}

cloudfoundry-bosh_cli-package-clean-pkg-removed:
  pkg.removed:
    - name: {{ cloudfoundry.bosh_cli.pkg.name }}

  {%- endif %}
  {%- if 'deps' in cloudfoundry.bosh_cli.pkg and cloudfoundry.bosh_cli.pkg.deps %}

cloudfoundry-bosh_cli-package-install-pkg-deps-installed:
  pkg.removed:
    - names: {{ cloudfoundry.bosh_cli.pkg.deps }}
    - refresh: True

  {%- endif %}
