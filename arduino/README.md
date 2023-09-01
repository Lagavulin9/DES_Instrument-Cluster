# Arduino
# Overview
Arduino is an open-source electronics platform based on easy-to-use hardware and software. Over the years Arduino has been the brain of thousands of projects, from everyday objects to complex scientific instruments. In this project we will use arduino to measure distance around the car, measure RPM of the wheel, and CAN communications.

#  Hardware Setup
## Components:
- **Arduino Nano**: The heart of our project. [Arduino Nano Official Store](https://store.arduino.cc/products/arduino-nano)
- **HC-SR04 UltraSonic Sensor**: For measuring distances. [Datasheet](https://www.handsontec.com/dataspecs/HC-SR04-Ultrasonic.pdf)
- **LM393 Speed Sensor**: For measuring RPM or rotational speed. [Datasheet](https://5.imimg.com/data5/VQ/DC/MY-1833510/lm393-motor-speed-measuring-sensor-module-for-arduino.pdf)
- **MCP2515 CAN Module**: For CAN communication. [Datasheet](https://ww1.microchip.com/downloads/en/DeviceDoc/MCP2515-Stand-Alone-CAN-Controller-with-SPI-20001801J.pdf)

## Wiring:
### Diagram
`put some image here`

- HC-SR04 UltraSonic Sensor:
	```
	TRIG_PIN to Arduino Nano Pin 7
	ECHO_PIN to Arduino Nano Pin 6
	VCC to 5V and GND to Ground
	```
- LM393 Speed Sensor:
	```
	Attach the output pin to Digital Pin 2 on the Arduino Nano for interrupt detection.
	VCC to 5V and GND to Ground
	```
- MCP2515 CAN Module:
	```
	Connect the MCP2515 module's CS pin to Arduino Nano Pin 9
	```

# Software Setup
## Arduino IDE
[Arduino IDE](https://www.arduino.cc/en/software) is needed to run arduino projects.

## Dependencies
autowp-mcp2515: Library for CAN module. Can be added using Library Manager in Arduino IDE, or can be manually downloaded and included.
[Project Link](https://github.com/autowp/arduino-mcp2515)

## CAN dataframe
`place some image here`
