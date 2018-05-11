# Made by Ville Touronen May 2018

# This installs SSH and configures firewall

install_ssh:
  pkg.installed:
    - pkgs:
      - openssh-server

# Replacing default rules with our own

/etc/ufw/user.rules:
  file.managed:
    - source: salt://ssh/user.rules

# Replacing default rules with our own

/etc/ufw/user6.rules:
  file.managed:
    - source: salt://ssh/user6.rules

# Replacing default SSH config file with our own

/etc/ssh/sshd_config:
  file.managed:
    - source: salt://ssh/sshd_config
    - template: jinja
    - context:
      port: 1337

# Start firewall

start_firewall:
  cmd.run:
    - name: sudo ufw enable

# Restart SSH if changes are made to the config file

ssh:
  service.running:
    - name: sshd
    - watch:
      - file: /etc/ssh/sshd_config

# Restart firewall if changes are made to the config file

firewall_restart:
  service.running:
    - name: ufw
    - watch:
      - file: /etc/ufw/user.rules
      - file: /etc/ufw/user6.rules

