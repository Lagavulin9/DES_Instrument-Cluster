# Services Documentation
This documentation provides an overview and setup guide for the CAN Receiver Service and PiRacer Service.

# Table of Contents
## Service Setup
- Overview
- Dependencies
- DBus
## CAN Receiver Service
- Description
- DBUS Interface
## PiRacer Service
- Description
- DBUS Interface
## Integration with Supervisor
- Overview
- Description
- Configuration

# Service Setup
## Overview
The CAN Receiver Service fetches data from the CAN bus and provides an interface to DBus. The PiRacer Service handles user inputs and monitors the PiRacer status, providing an interface to DBus.

## Dependencies
- **python-can**
	```
	pip install python-can
	```
- **pydbus**
	#### Install following packages:
	```
	sudo apt install \
		libgirepository1.0-dev \
		libcairo2-dev \
		pkg-config \
		python3-dev \
		gir1.2-gtk-3.0
	```
	#### Install python packages:
	```
	pip install \
		pycairo \
		PyGObject \
		pydbus
	```
- **supervisor**
	```
	sudo apt install supervisor
	```

# DBUS
In our project we use sessionbus for inter process communication.
- BUSNAME = ``

# CAN Receiver Service
## Description (CAN Receiver)
The CAN Receiver Service reads data packets from the CAN bus and updates RPM and distance values. It provides methods to fetch these values through the DBus interface.

## DBUS Interface (CAN Receiver)
Interface Name: `com.example.canService`
Object Path: `/com/example/canService`
> Note: By default object path follows the name of the interface
```
<method name='getDis'>
	<arg type='i' name='message' direction='out'/>
</method>

<method name='getRPM'>
	<arg type='i' name='message' direction='out'/>
</method>
```
`getDis`: Returns the current distance value in cm.

`getRPM`: Returns the current RPM value in integer.

# PiRacer Service
## Description (PiRacer)
The PiRacer Service communicates with the PiRacer vehicle and fetches battery-related details. It also processes user inputs from a gamepad to control the PiRacer.

## DBUS Interface (PiRacer)
Interface Name: `com.example.piracerService`
Object Path: `/com/example/piracerService`
> Note: By default object path follows the name of the interface
```
<method name='getVoltage'>
	<arg type='d' name='message' direction='out'/>
</method>

<method name='getCurrent'>
	<arg type='d' name='message' direction='out'/>
</method>
```
`getVoltage`: Returns the current voltage value in V.

`getCurrent`: Returns the current current value in mA.

# Integration with Supervisor
## Description
To achieve robustness, services should be able to restart in case of failure.

Supervisor is a client/server system that allows its users to control a number of processes on UNIX-like operating systems. Supervisor provides simple, efficient way of start, stop, and monitor processes. 

Both services are registered with the Supervisor process to ensure robustness and automatic restarts in case of failures.

## Configuration
To register these services with Supervisor, follow the below steps:

Create a Supervisor configuration file for each service under `/etc/supervisor/conf.d`

In my case, DBUS required these environment variables. Run this in terminal.
```
echo $DBUS_SESSION_BUS_ADDRESS
echo $XDG_RUNTIME_DIR
```
Add environment variable like this in .conf file
```
environment=VAR=value
```

After adding configuration files, reload config files.
```
#Reload the daemon’s configuration files
sudo supervisorctl reread
#Reload config and add/remove as necessary, and will restart affected programs
sudo supervisorctl update
```