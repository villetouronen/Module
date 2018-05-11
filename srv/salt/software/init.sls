# Made by Ville Touronen May 2018

# This installs Apache, PHP, SSH and other software

install_software:
  pkg.installed:
    - pkgs:
      - apache2
      - libapache2-mod-php
      - openssh-server
      - vlc
      - blender
      - shutter

# Apache and PHP

# Replaces Apaches default site to our test site

/var/www/html/index.html:
  file.managed:
    - source: salt://software/default.html

# Enable user directories and sites

a2enmod_userdir:
  cmd.run:
    - name: 'sudo a2enmod userdir'

# Restarting Apache

restart_apache2:
  cmd.run:
    - name: 'sudo systemctl restart apache2.service'

# Allowing use of PHP in Apache

/etc/apache2/mods_available/php7.0.conf:
  file.managed:
    - source: salt://software/php7.0.conf

# Restarting Apache

service_apache2:
  cmd.run:
    - name: 'sudo systemctl restart apache2.service'

# Firewall and SSH 

# Replacing default rules with our own

/etc/ufw/user.rules:
  file.managed:
    - source: salt://software/user.rules

# Replacing default rules with our own

/etc/ufw/user6.rules:
  file.managed:
    - source: salt://software/user6.rules

# Replacing default SSH config file with our own

/etc/ssh/sshd_config:
  file.managed:
    - source: salt://software/sshd_config
    - template: jinja
    - context:
      port: 1337

# Restart SSH if changes are made to the config file

ssh:
  service.running:
    - name: sshd
    - watch:
      - file: /etc/ssh/sshd_config

# Start firewall

start_firewall:
  cmd.run:
    - name: 'sudo ufw enable'

# Restart firewall if chacnges are made to the config file

firewall_restart:
  service.running:
    - name: ufw
    - watch:
      - file: /etc/ufw/user.rules
      - file: /etc/ufw/user6.rules
