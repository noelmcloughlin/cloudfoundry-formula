# -*- coding: utf-8 -*-
# vim: ft=sls

{#- Get the `tplroot` from `tpldir` #}
{%- set tplroot = tpldir.split('/')[0] %}
{%- from tplroot ~ "/map.jinja" import cloudfoundry with context %}

    {%- if cloudfoundry.pkg_deps %}

cloudfoundry-package-clean-pkg-deps-removed:
  pkg.removed:
    - name: {{ cloudfoundry.pkg }}

    {%- endif %}
    {%- if cloudfoundry.pkg %}

cloudfoundry-package-clean-pkg-removed:
  pkg.removed:
    - name: {{ cloudfoundry.pkg }}

    {%- endif %}
