
{#- Get the `tplroot` from `tpldir` #}
{%- set tplroot = tpldir.split('/')[0] %}
{%- from tplroot ~ "/map.jinja" import cloudfoundry with context %}

   {%- if cloudfoundry.bbl.pkg.use_upstream_repo %}
include:
  - .repo
   {%- endif %}

   {%- if 'deps' in cloudfoundry.bbl.pkg and cloudfoundry.bbl.pkg.deps %}

cloudfoundry-bbl-package-install-pkg-deps-installed:
  pkg.installed:
    - names: {{ cloudfoundry.bbl.pkg.deps }}
    - refresh: True

   {%- endif %}
   {%- if 'name' in cloudfoundry.bbl.pkg and cloudfoundry.bbl.pkg.name %}

cloudfoundry-bbl-package-install-pkg-installed:
  cmd.run:
    - name: mv /usr/local/bin/terraform /usr/local/bin/terraform_before_bbl
    - onlyif: test -f /usr/local/bin/terraform
  pkg.installed:
    - name: {{ cloudfoundry.bbl.pkg.name }}
    - refresh: True

   {%- endif %}
