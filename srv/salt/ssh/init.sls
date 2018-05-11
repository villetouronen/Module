# Made by Ville Touronen May 2018

# This installs SSH 

install_ssh:
  pkg.installed:
    - pkgs:
      - openssh-server

# Replacing default SSH config file with our own

/etc/ssh/sshd_config:
  file.managed:
    - source: salt://ssh/sshd_config
    - template: jinja
    - context:
      port: 1337

# Restart SSH if changes are made to the config file

ssh:
  service.running:
    - name: sshd
    - watch:
      - file: /etc/ssh/sshd_config


