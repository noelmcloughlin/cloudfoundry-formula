# -*- coding: utf-8 -*-
# vim: ft=sls

{#- Get the `tplroot` from `tpldir` #}
{%- set tplroot = tpldir.split('/')[0] %}
{%- from tplroot ~ "/map.jinja" import cloudfoundry with context %}

    {%- if cloudfoundry.pkg %}

cloudfoundry-package-install-pkg-installed:
  pkg.installed:
    - name: {{ cloudfoundry.pkg }}

    {%- endif %}
    {%- if cloudfoundry.pkg_deps %}

cloudfoundry-package-install-pkg-deps-installed:
  pkg.installed:
    - names: {{ cloudfoundry.pkg_deps }}

    {%- endif %}
