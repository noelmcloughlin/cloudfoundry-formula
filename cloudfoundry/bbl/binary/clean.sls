# -*- coding: utf-8 -*-
# vim: ft=sls

{#- Get the `tplroot` from `tpldir` #}
{%- set tplroot = tpldir.split('/')[0] %}
{%- from tplroot ~ "/map.jinja" import cloudfoundry with context %}

cloudfoundry-bbl-package-binary-clean-file-absent:
  file.absent:
    - name: {{ cloudfoundry.bbl.pkg.binary.dest }}/{{ cloudfoundry.bbl.pkg.binary.name }}
