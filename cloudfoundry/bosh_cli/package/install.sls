
{#- Get the `tplroot` from `tpldir` #}
{%- set tplroot = tpldir.split('/')[0] %}
{%- from tplroot ~ "/map.jinja" import cloudfoundry with context %}

   {%- if cloudfoundry.bosh_cli.pkg.use_upstream_repo %}
include:
  - .repo
   {%- endif %}

   {%- if 'deps' in cloudfoundry.bosh_cli.pkg and cloudfoundry.bosh_cli.pkg.deps %}

cloudfoundry-bosh_cli-package-install-pkg-deps-installed:
  pkg.installed:
    - names: {{ cloudfoundry.bosh_cli.pkg.deps }}
    - refresh: True

   {%- endif %}
   {%- if 'name' in cloudfoundry.bosh_cli.pkg and cloudfoundry.bosh_cli.pkg.name %}

cloudfoundry-bosh_cli-package-install-pkg-installed:
  pkg.installed:
    - name: {{ cloudfoundry.bosh_cli.pkg.name }}
    - refresh: True

   {%- endif %}
