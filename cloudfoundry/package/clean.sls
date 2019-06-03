# -*- coding: utf-8 -*-
# vim: ft=sls

{#- Get the `tplroot` from `tpldir` #}
{%- set tplroot = tpldir.split('/')[0] %}
{%- from tplroot ~ "/map.jinja" import cloudfoundry with context %}

    {%- if 'deps' in cloudfoundry.pkg and cloudfoundry.pkg.deps %}

cloudfoundry-package-clean-pkg-deps-removed:
  pkg.removed:
    - names: {{ cloudfoundry.pkg.deps }}

    {%- endif %}
    {%- if 'name' in cloudfoundry.pkg and cloudfoundry.pkg.name %}

cloudfoundry-package-clean-pkg-removed:
  pkg.removed:
    - name: {{ cloudfoundry.pkg.name }}

    {%- endif %}
