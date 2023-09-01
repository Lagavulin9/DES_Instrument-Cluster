# 2-CH CAN FD HAT (Rev2.1)
# Overview
The 2-Channel CAN bus expansion HAT is designed for Raspberry Pi, supports CAN FD (CAN with Flexible Data-Rate). It features multi onboard protection circuits, high anti-interference capability, and stable operation. 
# Dependencies
1. Open a terminal and run the following commands:
	```
	sudo raspi-config 
	Choose Interfacing Options -> I2C -> Yes.
	```
2. Reboot Raspberry Pi:
	```
	sudo reboot
	```
3. Install libraries:
- **bcmp2835**
	```
	wget http://www.airspayce.com/mikem/bcm2835/bcm2835-1.60.tar.gz
	tar zxvf bcm2835-1.60.tar.gz 
	cd bcm2835-1.60/
	sudo ./configure
	sudo make
	sudo make check
	sudo make install
	# For more information, please refer to the official website: http://www.airspayce.com/mikem/bcm2835/
	```
- **wiringPi**
	```
	sudo apt-get install wiringpi
	#For Raspberry Pi 4B may need to be upgraded:
	wget https://project-downloads.drogon.net/wiringpi-latest.deb
	sudo dpkg -i wiringpi-latest.deb
	gpio -v
	# Run gpio -v and version 2.52 will appear. If it does not appear, the installation is wrong
	```
- **python3**
	```
	sudo apt-get update
	sudo apt-get install python3-pip
	sudo apt-get install python3-pil
	sudo apt-get install python3-numpy
	sudo pip3 install RPi.GPIO
	sudo pip3 install spidev 
	sudo pip3 install python-can
	```

# Dual SPI Mode
This is a hardware default mode, namely:
CAN_0 uses SPI0-0, interrupt pin is 25, CAN_1 uses SPI1-0, interrupt pin is 24.

Insert the module to Raspberry Pi, and then modify config.txt file:
```
sudo nano /boot/config.txt
```
Add the following commands at the last line:
```
dtparam=spi=on
dtoverlay=spi1-3cs
dtoverlay=mcp251xfd,spi0-0,interrupt=25
dtoverlay=mcp251xfd,spi1-0,interrupt=24
```

# Configure CAN
Set the baud rate, operating mode, whether to enable FD, and configure the transmission buffer size:
```
sudo ip link set can0 up type can bitrate 1000000 dbitrate 8000000 restart-ms 1000 berr-reporting on fd on
sudo ip link set can1 up type can bitrate 1000000 dbitrate 8000000 restart-ms 1000 berr-reporting on fd on
```
bitrate xxxxxx (bps)：arbitration bitrate
dbitrate xxxxxx (bps)：data bitrate

# Testing
Install can-utils:
```
sudo apt-get install can-utils
```
One of the terminal inputs receives the CAN0 data command:
```
candump can0
```

# Reference
Waveshare wiki: [2-CH CAN FD HAT](https://www.waveshare.com/wiki/2-CH_CAN_FD_HAT)