# -*- coding: utf-8 -*-
# vim: ft=sls

{#- Get the `tplroot` from `tpldir` #}
{%- set tplroot = tpldir.split('/')[0] %}
{%- from tplroot ~ "/map.jinja" import cloudfoundry with context %}

cloudfoundry-bosh_cli-package-binary-clean-file-absent:
  file.absent:
    - name: {{ cloudfoundry.bosh_cli.pkg.binary.dest }}/{{ cloudfoundry.bosh_cli.pkg.binary.name }}
