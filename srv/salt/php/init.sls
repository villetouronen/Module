# Made by Ville Touronen May 2018

# This installs PHP

install_php:
  pkg.installed:
    - pkgs:
      - libapache2-mod-php

# Allowing use of PHP in Apache

/etc/apache2/mods-available/php7.0.conf:
  file.managed:
    - source: salt://php/php7.0.conf

# Restarting Apache

service_apache2:
  cmd.run:
    - name: sudo systemctl restart apache2.service

