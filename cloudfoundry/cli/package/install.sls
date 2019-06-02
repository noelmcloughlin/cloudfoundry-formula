
{#- Get the `tplroot` from `tpldir` #}
{%- set tplroot = tpldir.split('/')[0] %}
{%- from tplroot ~ "/map.jinja" import cloudfoundry with context %}

{%- if cloudfoundry.cli.pkg.use_upstream %}
  {%- set sls_repo = tplroot ~ '.cli.package.repo' %}
include:
  - {{ sls_repo }}
{%- endif %}

    {%- if cloudfoundry.cli.pkg.gem %}

cloudfoundry-cli-package-install-gem-removed:
  gem.removed:
    - name: {{ cloudfoundry.cli.pkg.gem }}

    {%- endif %}
    {%- if cloudfoundry.cli.pkg.name %}

cloudfoundry-cli-package-install-pkg-installed:
  pkg.installed:
    - name: {{ cloudfoundry.cli.pkg.name }}
    - refresh: True
        {%- if 'from' in cloudfoundry.cli.pkg.repo and cloudfoundry.cli.pkg.repo.from %}
    - fromrepo: {{ cloudfoundry.cli.pkg.repo.from }}
        {%- endif -%}

    {%- endif %}
