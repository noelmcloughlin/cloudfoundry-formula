# -*- coding: utf-8 -*-
# vim: ft=sls

{#- Get the `tplroot` from `tpldir` #}
{%- set tplroot = tpldir.split('/')[0] %}
{%- from tplroot ~ "/map.jinja" import cloudfoundry with context %}

    {%- if 'name' in cloudfoundry.pkg and cloudfoundry.pkg.name %}

cloudfoundry-package-install-pkg-installed:
  pkg.installed:
    - name: {{ cloudfoundry.pkg.name }}

    {%- endif %}
    {%- if 'deps' in cloudfoundry.pkg and cloudfoundry.pkg.deps %}

cloudfoundry-package-install-pkg-deps-installed:
  pkg.installed:
    - names: {{ cloudfoundry.pkg.deps }}

    {%- endif %}
