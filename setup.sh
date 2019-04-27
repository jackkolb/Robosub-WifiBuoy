echo Created by UCR RoboSub, 2019
echo This script installs and sets up the WiFi Buoy software, press [ENTER] to begin
read temp

echo Beginning setup
echo Updating Raspian
sudo apt-get update
sudo apt-get upgrade

echo installing dnsmasq and hostapd
sudo apt-get install dnsmasq hostapd

echo stopping the dnsmasq and hostapd services
sudo systemctl stop dnsmasq
sudo systemctl stop hostapd

echo copying over the dhcpcd.conf file
sudo cp dhcpcd.conf.robosub /etc/dhcpcd.conf

echo restarting dhcpcd
sudo service dhcpcd restart

echo copying over the dnsmasq.conf file
sudo cp dnsmasq.conf.robosub /etc/dnsmasq.conf

echo copying over the hostapd.conf file
sudo cp hostapd.conf.robosub /etc/hostapd/hostapd.conf

echo copying over the default/hostapd file
sudo cp default.hostapd.robosub /etc/default/hostapd

echo starting up the services
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