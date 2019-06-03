# -*- coding: utf-8 -*-
# vim: ft=sls

{#- Get the `tplroot` from `tpldir` #}
{%- set tplroot = tpldir.split('/')[0] %}
{%- from tplroot ~ "/map.jinja" import cloudfoundry with context %}
{%- from tplroot ~ "/jinja/macros.jinja" import format_kwargs with context %}

cloudfoundry-cli-package-archive-install-file-directory:
  file.directory:
    - name: {{ cloudfoundry.tmpdir }}
    - group: {{ cloudfoundry.rootgroup }}
    - makedirs: True
    - onlyif: {{ cloudfoundry.cli.pkg.archive.extracted.name != '/tmp' }}
    - require_in:
      - archive: cloudfoundry-cli-package-archive-install-archive-extracted

cloudfoundry-cli-package-archive-install-cmd-run:
  cmd.run:
    - name: curl -s -L -o {{cloudfoundry.cli.pkg.archive.extracted.source}} {{cloudfoundry.cli.pkg.archive.source}}
    - unless: test -f {{ cloudfoundry.cli.pkg.archive.extracted.source }}
    - retry:
        attempts: 2
        until: True
        interval: 60
        splay: 10

cloudfoundry-cli-package-archive-install-archive-extracted:
   {%- if grains.os == 'MacOS' %}
  macpackage.installed:
    - name: {{ cloudfoundry.cli.pkg.archive.extracted.source }}
    - store: True
    - dmg: False
    - app: False
    - force: True
    - allow_untrusted: True
   {%- else %}
  archive.extracted:
    {{- format_kwargs(cloudfoundry.cli.pkg.archive.extracted) }}

   {%- endif %}
