# -*- coding: utf-8 -*-
# vim: ft=sls

{#- Get the `tplroot` from `tpldir` #}
{%- set tplroot = tpldir.split('/')[0] %}
{%- from tplroot ~ "/map.jinja" import template with context %}

    {%- if cloudfoundry.pkg_deps %}

template-package-clean-pkg-deps-removed:
  pkg.removed:
    - name: {{ template.pkg }}

    {%- endif %}
    {%- if cloudfoundry.pkg %}

template-package-clean-pkg-removed:
  pkg.removed:
    - name: {{ template.pkg }}

    {%- endif %}
