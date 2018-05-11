# Made by Ville Touronen May 2018

# This installs Apache

install_apache:
  pkg.installed:
    - pkgs:
      - apache2

# Replaces Apaches default site to our test site

/var/www/html/index.php:
  file.managed:
    - source: salt://apache/index.php

# Enable user directories and sites

/etc/apache2/mods-enabled/userdir.conf:
  file.symlink:
    - target: ../mods-enabled/userdir.conf

/etc/apache2/mods-enabled/userdir.load:
  file.symlink:
    - target: ../mods-enabled/userdir.load


# Restart Apache if configuration files are changed

restart_apache2:
  service.running:
    - name: apache2
    - watch:
      - file: /etc/apache2/mods-enabled/userdir.conf
      - file: /etc/apache2/mods-enabled/userdir.load



