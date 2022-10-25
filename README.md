RoboSub Wifi Buoy

This script sets up the wifi system for RoboSub's Wifi Buoy.

`$ ./setup.sh`

It converts a Raspberry Pi to broadcast a wifi signal, allowing us to SSH to a computer via the attached ethernet cable.

To use:

1. Connect your SSH device to the Raspberry Pi's WiFi signal, and the Raspberry Pi to the Jetson.

2. The Jetson *should* be registered to 192.168.5.2, SSH to that address.

3. Run whatever you need to start the sub :)
