# Original by Tero Karvinen Copyright 2018 Tero Karvinen http://TeroKarvinen.com GPL 3

# This installs Apache

apache2:
  pkg.installed

# Replaces Apaches default site to our test site

/var/www/html/index.html:
  file.managed:
    - source: salt://apache/index.php

# Enable user directories and sites

/etc/apache2/mods-enabled/userdir.conf:
  file.symlink:
    - target: ../mods-available/userdir.conf

/etc/apache2/mods-enabled/userdir.load:
  file.symlink:
    - target: ../mods-available/userdir.load

# Restart Apache

serviceapache2:
  service.running:
    - name: apache2
    - watch:
      - file: /etc/apache2/mods-enabled/userdir.conf
      - file: /etc/apache2/mods-enabled/userdir.conf


