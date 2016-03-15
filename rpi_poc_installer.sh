#!/bin/bash

echo " *** [1] Installing and configuring Kismet and Python Thrift client *** "

sudo apt-get -y update

# =========== GPSd, ntp, iw scripts ============ #
sudo apt-get install gpsd gpsd-clients ntp iw

# =========== Kismet installation ============ #
sudo apt-get -y install git
#sudo apt-get -y install ncurses-dev libpcap-dev libnl-dev
sudo apt-get -y install libncurses5-dev libpcre3-dev libpcap-dev libnl-dev
wget https://www.kismetwireless.net/code/kismet-2016-01-R1.tar.xz
tar xvfJ kismet-2016-01-R1.tar.xz
cd kismet-2016-01-R1
./configure 
make
sudo make install suidinstall
sudo usermod -a -G kismet pi

# =========== MAC Address Manufacturer file, plugins and log folder for Kismet ============ #
wget -O manuf http://anonsvn.wireshark.org/wireshark/trunk/manuf
sudo cp manuf /etc/manuf

# =========== Python Kismet and Python Thrift libs installation ============ #
sudo apt-get -y install subversion
svn checkout --trust-server-cert --non-interactive https://github.com/chilcano/iot-server-appliances/trunk/Arduino%20Robot/PC_Clients/PythonRobotController/DirectPublishClient/BAMPythonPublisher
git -c http.sslVerify=false clone https://github.com/chilcano/kismetclient

# =========== Copy the bash runner script ============ #
chmod +x rpi_poc_runner.sh

echo " ... ready, now run 'rpi_poc_runner.sh' !!!"
