#!/bin/sh
echo "\nRemoving Postgres & PgAdmin..."
echo
sudo dpkg --configure -a
sudo apt-get --purge remove postgresql*
sudo rm -r /etc/postgresql/
sudo rm -r /etc/postgresql-common/
sudo rm -r /var/lib/postgresql/
sudo userdel -r postgres
sudo groupdel postgres
sudo apt -y autoremove
sudo apt -y autoremove pgadmin4
sudo apt-get update
sudo apt-get -y upgrade
sudo apt -y autoremove
sudo apt autoclean
sudo apt clean
echo "Done!!!"