# -*- coding: utf-8 -*-
# vim: ft=sls

{#- Get the `tplroot` from `tpldir` #}
{%- set tplroot = tpldir.split('/')[0] %}
{%- from tplroot ~ "/map.jinja" import cloudfoundry with context %}

  {%- if cloudfoundry.bbl.pkg.use_upstream_repo %}
include:
  - .repo.clean

  {%- endif %}
  {%- if 'name' in cloudfoundry.bbl.pkg and cloudfoundry.bbl.pkg.name %}

cloudfoundry-bbl-package-clean-pkg-removed:
  pkg.removed:
    - name: {{ cloudfoundry.bbl.pkg.name }}

  {%- endif %}
  {%- if 'deps' in cloudfoundry.bbl.pkg and cloudfoundry.bbl.pkg.deps %}

cloudfoundry-bbl-package-install-pkg-deps-installed:
  pkg.removed:
    - names: {{ cloudfoundry.bbl.pkg.deps }}
    - refresh: True

  {%- endif %}
