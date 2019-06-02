
{#- Get the `tplroot` from `tpldir` #}
{%- set tplroot = tpldir.split('/')[0] %}
{%- from tplroot ~ "/map.jinja" import cloudfoundry with context %}

  {%- if cloudfoundry.cli.pkg.use_upstream_repo %}

include:
  - .repo

  {%- endif %}


cloudfoundry-cli-package-install-gem-removed:
  gem.removed:
    - name: {{ cloudfoundry.cli.pkg.gem }}

cloudfoundry-cli-package-install-pkg-installed:
  pkg.installed:
    - name: {{ cloudfoundry.cli.pkg.name }}
    - refresh: True

