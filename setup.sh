echo Created by UCR RoboSub, 2019
echo This script installs and sets up the WiFi Buoy software, press [ENTER] to begin

echo If something doesn't work, try updating raspian (sudo apt-get upgrade)

echo beginning setup

echo making file backups (STORE THESE ELSEWHERE IN CASE YOU RUN THIS SCRIPT TWICE!)
sudo cp /etc/dhcpcd.conf /etc/dhcpcd.conf.BACKUP
sudo cp /etc/dnsmasq.conf /etc/dnsmasq.conf.BACKUP
sudo cp /etc/hostapd.conf /etc/hostapd.conf.BACKUP
sudo cp /etc/default/dnsmasq /etc/default/dnsmasq.BACKUP
sudo cp /etc/default/hostapd /etc/default/hostapd.BACKUP

echo installing dnsmasq and hostapd
sudo apt-get install dnsmasq hostapd

echo stopping the dnsmasq and hostapd services
sudo systemctl stop dnsmasq
sudo systemctl stop hostapd

echo copying over the dhcpcd.conf file
sudo cp dhcpcd.conf.robosub /etc/dhcpcd.conf

echo restarting dhcpcd
sudo service dhcpcd restart

echo copying over the dnsmasq files
sudo cp dnsmasq.conf.robosub /etc/dnsmasq.conf
sudo cp default.dnsmasq.conf.robosub /etc/default/dnsmasq

echo copying over the hostapd files
sudo cp hostapd.conf.robosub /etc/hostapd/hostapd.conf
sudo cp default.hostapd.robosub /etc/hostapd/hostapd

echo copying over the network interface
sudo cp network.interfaces.robosub /etc/network/interfaces

echo starting up the services
sudo systemctl enable hostapd
sudo systemctl enable dnsmasq
sudo systemctl start hostapd
sudo systemctl start dnsmasq

echo copying over the sysctl.conf file
sudo cp sysctl.conf.robosub /etc/sysctl.conf

echo doing iptables
sudo iptables -t nat -A POSTROUTING -o eth0 -j MASQUERADE
sudo sh -c "iptables-save > /etc/iptables.ipv4.nat"
sudo iptables-restore < /etc/iptables.ipv4.nat

echo setup complete
echo press [ENTER] to reboot!
sudo reboot
