# -*- coding: utf-8 -*-
# vim: ft=sls

{#- Get the `tplroot` from `tpldir` #}
{%- set tplroot = tpldir.split('/')[0] %}
{%- from tplroot ~ "/map.jinja" import cloudfoundry with context %}

cloudfoundry-cli-package-repo-clean-pkgrepo-absent:
  pkgrepo.absent:
    - name: {{ cloudfoundry.cli.pkg.repo.name }}
