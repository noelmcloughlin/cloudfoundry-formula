# -*- coding: utf-8 -*-
# vim: ft=sls

{#- Get the `tplroot` from `tpldir` #}
{%- set tplroot = tpldir.split('/')[0] %}
{%- from tplroot ~ "/map.jinja" import cloudfoundry with context %}
{%- from tplroot ~ "/jinja/macros.j2" import format_kwargs with context -%}

cloudfoundry-cli-package-archive-file-directory:
  file.directory:
    - name: {{ cloudfoundry.cli.pkg.archive.extracted.name }}
    - user: {{ cloudfoundry.cli.pkg.archive.extracted.user }}
    - group: {{ cloudfoundry.cli.pkg.archive.extracted.group }}
    - mode: '0755'
    - makedirs: True
    - onlyif: {{ cloudfoundry.cli.pkg.archive.extracted.name != '/tmp' %}
    - require_in:
      - cloudfoundry-cli-package-archive-wanted-download-{{ package }}

cloudfoundry-cli-package-archive-install-archive-extracted:
  archive.extracted:
    {{- format_kwargs(cloudfoundry.cli.pkg.archive.extracted) }}
    - enforce_toplevel: {{ 'False' if 'strip-components' in cloudfoundry.cli.pkg.archive.extracted.options else 'True' }}
    - require:
      - cloudfoundry-cli-package-archive-wanted-download-{{ package }}

