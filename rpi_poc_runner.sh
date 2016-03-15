#!/bin/bash

echo " *** [2] Starting GPSd, Kismet and sending 802.11 captured traffic to WSO2 BAM *** "

RPI2BAM_POC_HOME="/home/pi/_kismet2das"
RPI2BAM_POC_LOGS="/home/pi/_kismetlogs"

# setting NIC in monitor mode
sudo ifconfig wlan0 down
sudo iwconfig wlan0 mode monitor
sudo ifconfig wlan0 up

# enabling GPS
sudo killall gpsd
sudo gpsd /dev/ttyUSB0 -F /var/run/gpsd.sock
sleep 3

# refreshing the Time server
sudo service ntp restart
sleep 3

# starting Kismet server in background
sudo killall kismet_server
mkdir -p $RPI2BAM_POC_LOGS
kismet_server -p $RPI2BAM_POC_LOGS -c wlan0 --daemonize

# running the Python Thrift Client
sleep 5
cd $RPI2BAM_POC_HOME/python-thrift-cli/
python sendTrafficFromKismetToWSO2BAM.py