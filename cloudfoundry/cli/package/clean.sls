# -*- coding: utf-8 -*-
# vim: ft=sls

{#- Get the `tplroot` from `tpldir` #}
{%- set tplroot = tpldir.split('/')[0] %}
{%- set sls_repo_clean = tplroot ~ '.repo.clean' %}
{%- from tplroot ~ "/map.jinja" import cloudfoundry with context %}

include:
  - {{ sls_repo_clean }}

cloudfoundry-cli-package-clean-pkg-removed:
  pkg.removed:
    - name: {{ cloudfoundry.cli.pkg.name }}

    {%- if cloudfoundry.cli.pkg.use_upstream %}

cloudfoundry-cli-package-clean-repo-absent:
  pkgrepo.absent:
    - name: {{ cloudfoundry.cli.pkg.repo.name }}
    - require:
      - pkg: cloudfoundry-package-clean-pkg-removed
      - sls: {{ sls_repo_clean }}

    {%- endif %}
