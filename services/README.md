# DBus setup
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
## Interfaces
I will add some diagrams later.

## Run
```
python3 canService.py &
python3 piracerService.py &
```