# Made by Ville Touronen May 2018

# Firewall configuration

# Allowing port 22 on firewall

allow_firewall:
  cmd.run:
    - name: 'sudo ufw allow 22/tcp'

# Allowing port 80 on firewall

allow_firewall2:
  cmd.run:
    - name: 'sudo ufw allow 80/tcp'

# Allowing port 1337 on firewall        

allow_firewall3:
  cmd.run:
    - name: 'sudo ufw allow 1337/tcp'


# Start firewall

enable_firewall:
  cmd.run:
    - name: 'sudo ufw enable'

