
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
    - onlyif: gem >/dev/null 2>&1

    {%- if 'deps' in cloudfoundry.cli.pkg and cloudfoundry.cli.pkg.deps %}

cloudfoundry-cli-package-install-pkg-installed:
  pkg.installed:
    - names: {{ cloudfoundry.cli.pkg.deps }}

    {%- endif %}

cloudfoundry-cli-package-install-pkg-installed:
  pkg.installed:
    - name: {{ cloudfoundry.cli.pkg.name }}
    - refresh: True
