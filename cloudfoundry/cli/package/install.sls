# -*- coding: utf-8 -*-
# vim: ft=sls

{#- Get the `tplroot` from `tpldir` #}
{%- set tplroot = tpldir.split('/')[0] %}
{%- set sls_repo = tplroot ~ '.repo' %}
{%- from tplroot ~ "/map.jinja" import cloudfoundry with context %}

include:
  - {{ sls_repo }}

    {%- if cloudfoundry.cli.pkg.deps %}

cloudfoundry-cli-package-deps-installed:
  pkg.installed:
    - name: {{ cloudfoundry.cli.pkg.deps }}

    {%- endif %}
    {%- if cloudfoundry.cli.pkg.gem %}

cloudfoundry-cli-package-gem-removed:
  gem.removed:
    - name: {{ cloudfoundry.cli.gem }}

    {%- endif %}

cloudfoundry-package-install-pkg-installed:
  pkg.installed:
    - name: {{ cloudfoundry.cli.pkg }}
    - refresh: True
    - require:
      - pkgrepo: cloudfoundry-cli-package-repo-installed:
        {%- if cloudfoundry.cli.pkg.repo.from %}
    - fromrepo: {{ cloudfoundry.cli.pkg.repo.from }}
        {%- endif -%}
