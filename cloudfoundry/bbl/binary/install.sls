# -*- coding: utf-8 -*-
# vim: ft=sls

{#- Get the `tplroot` from `tpldir` #}
{%- set tplroot = tpldir.split('/')[0] %}
{%- from tplroot ~ "/map.jinja" import cloudfoundry with context %}
{%- from tplroot ~ "/jinja/macros.jinja" import format_kwargs with context %}

cloudfoundry-bbl-package-binary-install-file-directory:
  file.directory:
    - name: {{ cloudfoundry.bbl.pkg.binary.dest }}
    - group: {{ cloudfoundry.rootgroup }}
    - makedirs: True
    - require_in:
      - binary: cloudfoundry-bbl-package-binary-install-cmd-run

cloudfoundry-bbl-package-binary-install-cmd-run:
  cmd.run:
    - name: curl -s -L -o {{cloudfoundry.bbl.pkg.binary.dest}}/{{cloudfoundry.bbl.pkg.binary.name}} {{cloudfoundry.bbl.pkg.binary.source}}
    - unless: test -f {{cloudfoundry.bbl.pkg.binary.dest}}/{{cloudfoundry.bbl.pkg.binary.name}}
    - retry:
        attempts: 2
        until: True
        interval: 60
        splay: 10
    {%- if 'source_hash' in cloudfoundry.bbl.pkg.binary and cloudfoundry.bbl.pkg.binary.source_hash %}
  module.run:
    - name: file.check_hash
    - path: {{cloudfoundry.bbl.pkg.binary.dest}}/{{cloudfoundry.bbl.pkg.binary.name}}
    - file_hash: {{ cloudfoundry.bbl.pkg.binary.source_hash }}
    {%- endif %}
  file.managed:
    - name: {{cloudfoundry.bbl.pkg.binary.dest}}/{{cloudfoundry.bbl.pkg.binary.name}}
    - mode: '0755'
    - require:
      - module: cloudfoundry-bbl-package-binary-install-cmd-run

cloudfoundry-bbl-package-binary-install-file-absent:
  file.absent:
    - name: {{ cloudfoundry.bbl.pkg.binary.dest }}/{{ cloudfoundry.bbl.pkg.binary.name }}
    - onfail:
        - module: cloudfoundry-bbl-package-binary-install-cmd-run
