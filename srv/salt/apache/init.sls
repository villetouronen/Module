# Made by Ville Touronen May 2018

# This installs Apache

install_apache:
  pkg.installed:
    - pkgs:
      - apache2

# Replaces Apaches default site to our test site

/var/www/html/index.html:
  file.managed:
    - source: salt://apache/index.php

# Enable user directories and sites

a2enmod_userdir:
  cmd.run:
    - name: sudo a2enmod userdir

# Restarting Apache

restart_apache2:
  cmd.run:
    - name: sudo systemctl restart apache2.service



