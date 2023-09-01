# 7.9 inch DSI LCD
# Overview
7.9inch IPS display with capacitive touch panel, hardware resolution is 400 x 1280.

Works with Raspberry Pi, provided with the driver for Raspberry Pi OS.
# Installation
```
#Step 1: Download and enter the Waveshare-DSI-LCD driver folder
git clone https://github.com/waveshare/Waveshare-DSI-LCD
cd Waveshare-DSI-LCD
 
#Step 2: Enter uname -a in the terminal to view the kernel version and cd to the corresponding file directory
#6.1.21 then run the following command
cd 6.1.21
 
#Step 3: Please check the bits of your system, enter the 32 directory for 32-bit systems, and enter the 64 directory for 64-bit systems
cd 32
#cd 64
 
#Step 4: Enter your corresponding model command to install the driver, pay attention to the selection of the I2C DIP switch
#7.9inch DSI LCD 400×1280 driver：
sudo bash ./WS_xinchDSI_MAIN.sh 79 I2C0
 
#Step 5: Wait for a few seconds, when the driver installation is complete and no error is prompted, restart and load the DSI driver and it can be used normally
sudo reboot
```

# Reference
Waveshare wiki: [7.9 inch DSI LCD](https://www.waveshare.com/wiki/7.9inch_DSI_LCD)