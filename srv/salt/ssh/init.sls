# Made by Ville Touronen May 2018

# This installs SSH 

ssh:
  pkg.installed

# Replacing default SSH config file with our own

{% for port in ['1337'] %}

/etc/ssh/sshd_config:
  file.managed:
    - source: salt://ssh/sshd_config
    - template: jinja
    - context:
      port: {{ port }}

{% endfor %}

# Restart SSH if changes are made to the config file

restart_ssh:
  service.running:
    - name: 'sshd'
    - watch:
      - file: /etc/ssh/sshd_config


