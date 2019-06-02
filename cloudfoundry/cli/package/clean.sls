# -*- coding: utf-8 -*-
# vim: ft=sls

{#- Get the `tplroot` from `tpldir` #}
{%- set tplroot = tpldir.split('/')[0] %}
{%- set sls_config_clean = tplroot ~ '.config.clean' %}
{%- from tplroot ~ "/map.jinja" import cloudfoundry with context %}

include:
  - {{ sls_config_clean }}

cloudfoundry-cli-package-clean-pkg-removed:
  pkg.removed:
    - name: {{ cloudfoundry.cli.pkg.name }}
    - require:
      - sls: {{ sls_config_clean }}

    {%- if cloudfoundry.cli.pkg.use_upstream %}

cloudfoundry-cli-package-clean-repo-absent:
  pkgrepo.absent:
    - name: {{ cloudfoundry.cli.pkg.repo.name }}
    - require:
      - pkg: cloudfoundry-package-clean-pkg-removed

    {%- endif %}
    {%- if cloudfoundry.cli.pkg.deps %}

cloudfoundry-cli-package-clean-deps-pkg-removed:
  pkg.removed:
    - name: {{ cloudfoundry.cli.pkg.deps }}
    - require:
      - pkg: cloudfoundry-package-clean-pkg-removed

    {%- endif %}
