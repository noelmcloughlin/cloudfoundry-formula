# -*- coding: utf-8 -*-
# vim: ft=sls

{#- Get the `tplroot` from `tpldir` #}
{%- set tplroot = tpldir.split('/')[0] %}
{%- from tplroot ~ "/map.jinja" import template with context %}

    {%- if cloudfoundry.pkg %}

template-package-install-pkg-installed:
  pkg.installed:
    - name: {{ template.pkg }}

    {%- endif %}
    {%- if cloudfoundry.pkg_deps %}

template-package-install-pkg-deps-installed:
  pkg.installed:
    - name: {{ template.pkg_deps }}

    {%- endif %}
