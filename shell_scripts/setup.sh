#!/bin/sh
echo "\nUpdating OS..."
echo
sudo dpkg --configure -a
sudo apt-get update
sudo apt-get -y upgrade
echo "\nChecking Python Version..."
req=`python3 -c 'import sys; print("%i" % (sys.hexversion<0x03000000))'`
if [ $req -eq 0 ]; then
    echo '\nPython version is >= 3'
    echo 'Installing dependices...'
    echo 
    sudo apt-get install python3-pip gcc libexpat1-dev\
                         python-pip-whl python3-dev\
                         python-dev python3-setuptools python3-wheel\
                         build-essential git ffmpeg libsdl2-dev\
                         libsdl2-image-dev libsdl2-mixer-dev libsdl2-ttf-dev\
                         libportmidi-dev libswscale-dev libavformat-dev libavcodec-dev\
                         zlib1g-dev swig libpulse-dev libasound2-dev libevent-dev 
    sudo apt-get update
else
    echo "\nPython version is < 3"
    echo "Installing Python3+ and dependencies..." 
    echo
    sudo apt-get install python-dev python3 python3-pip gcc libexpat1-dev\
                         python-pip-whl python3-setuptools python3-wheel build-essential\
                         git python3-dev ffmpeg libsdl2-dev libsdl2-image-dev libsdl2-mixer-dev\
                         libsdl2-ttf-dev libportmidi-dev libswscale-dev libavformat-dev libavcodec-dev\
                         zlib1g-dev swig libpulse-dev libasound2-dev libevent-dev
    sudo apt-get update
fi
read -p "\nInstall Google Chrome & VScode? (y/n)" ok
echo "\nInstalling Google Chrome..."
echo
wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
sudo dpkg -i google-chrome-stable_current_amd64.deb
echo "\nInstalling VScode..."
echo
sudo snap install --classic code
if ! [ $ok = "y" -o $ok = "Y" ]; then 
    echo '\nIgnoring...'
fi
echo "\nInstalling Postgres & PgAdmin..."
echo
sudo apt -y install postgresql 
req=`sudo systemctl is-active postgresql`
if [ $req = "active" ]; then
    echo '\npostgresql active'
else
    echo '\nPostgres error exiting!!!'
    exit 1
fi
req=`sudo systemctl is-enabled postgresql`
if [ $req = "enabled" ]; then
    echo '\npostgresql enabled'
else
    echo '\nPostgres error exiting!!!'
    exit 1
fi
echo n | sudo systemctl status postgresql
echo
echo n | sudo pg_isready
echo "\nInstalling PgAdmin..."
echo
curl https://www.pgadmin.org/static/packages_pgadmin_org.pub | sudo apt-key add
sudo sh -c 'echo "deb https://ftp.postgresql.org/pub/pgadmin/pgadmin4/apt/$(lsb_release -cs) pgadmin4 main" > /etc/apt/sources.list.d/pgadmin4.list && apt update'
sudo apt -y install pgadmin4 
sudo /usr/pgadmin4/bin/setup-web.sh
echo '\nInstalling nessesary python packages...'
echo
pip install --upgrade wheel
pip install --upgrade sdist
pip install --upgrade setuptools
sudo pip install -r requirements.txt
echo '\nInstalling td-ml-bot...'
cd /home/path/
mkdir foldername
cd /home/path/foldername 
pwd
sudo git clone https://github.com/user/project.git
sudo chmod +777 project/
cd /home/path/foldername/project
ls 
echo 'Done!!!'