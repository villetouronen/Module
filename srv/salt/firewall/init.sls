# Firewall configuration

# Replacing default rules with our own

/etc/ufw/user.rules:
  file.managed:
    - source: salt://ssh/user.rules

# Replacing default rules with our own

/etc/ufw/user6.rules:
  file.managed:
    - source: salt://ssh/user6.rules

# Start firewall

start_firewall:
  cmd.run:
    - name: sudo ufw enable

# Restart firewall if changes are made to the config file

firewall_restart:
  service.running:
    - name: ufw
    - watch:
      - file: /etc/ufw/user.rules
      - file: /etc/ufw/user6.rules
