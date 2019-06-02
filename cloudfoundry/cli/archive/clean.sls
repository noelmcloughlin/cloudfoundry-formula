# -*- coding: utf-8 -*-
# vim: ft=sls

{#- Get the `tplroot` from `tpldir` #}
{%- set tplroot = tpldir.split('/')[0] %}
{%- from tplroot ~ "/map.jinja" import cloudfoundry with context %}

cloudfoundry-cli-package-archive-clean-file-absent:
  file.absent:
    - name: {{ cloudfoundry.cli.pkg.archive.extracted.name }}/{{ cloudfoundry.cli.pkg.archive.extracted.binary }}
