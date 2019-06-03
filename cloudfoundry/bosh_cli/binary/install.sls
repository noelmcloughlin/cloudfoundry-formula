# -*- coding: utf-8 -*-
# vim: ft=sls

{#- Get the `tplroot` from `tpldir` #}
{%- set tplroot = tpldir.split('/')[0] %}
{%- from tplroot ~ "/map.jinja" import cloudfoundry with context %}
{%- from tplroot ~ "/jinja/macros.jinja" import format_kwargs with context %}

cloudfoundry-bosh_cli-package-binary-install-file-directory:
  file.directory:
    - name: {{ cloudfoundry.bosh_cli.pkg.binary.dest }}
    - group: {{ cloudfoundry.rootgroup }}
    - makedirs: True
    - require_in:
      - binary: cloudfoundry-bosh_cli-package-binary-install-cmd-run

cloudfoundry-bosh_cli-package-binary-install-cmd-run:
  cmd.run:
    - name: curl -s -L -o {{cloudfoundry.bosh_cli.pkg.binary.dest}}/{{cloudfoundry.bosh_cli.pkg.binary.name}} {{cloudfoundry.bosh_cli.pkg.binary.source}}
    - unless: test -f {{cloudfoundry.bosh_cli.pkg.binary.dest}}/{{cloudfoundry.bosh_cli.pkg.binary.name}}
    - retry:
        attempts: 2
        until: True
        interval: 60
        splay: 10
    {%- if 'source_hash' in cloudfoundry.bosh_cli.pkg.binary and cloudfoundry.bosh_cli.pkg.binary.source_hash %}
  module.run:
    - name: file.check_hash
    - path: {{cloudfoundry.bosh_cli.pkg.binary.dest}}/{{cloudfoundry.bosh_cli.pkg.binary.name}}
    - file_hash: {{ cloudfoundry.bosh_cli.pkg.binary.source_hash }}
    {%- endif %}
  file.managed:
    - name: {{cloudfoundry.bosh_cli.pkg.binary.dest}}/{{cloudfoundry.bosh_cli.pkg.binary.name}}
    - mode: '0755'
    - require:
      - module: cloudfoundry-bosh_cli-package-binary-install-cmd-run

cloudfoundry-bosh_cli-package-binary-install-file-absent:
  file.absent:
    - name: {{ cloudfoundry.bosh_cli.pkg.binary.dest }}/{{ cloudfoundry.bosh_cli.pkg.binary.name }}
    - onfail:
        - module: cloudfoundry-bosh_cli-package-binary-install-cmd-run
