# Dashboard
## Installation
#### Install snap
```
sudo apt install snapd
```
#### Reboot
```
sudo reboot
```
#### Install `core` snap
```
sudo snap install core
```
#### Install flutter
```
sudo snap install flutter --classic
```
#### Run flutter doctor
```
flutter doctor
```
#### Update PATH
in your `~/.bashrc`, add this line:
```
export PATH="$PATH:{FLUTTER_SDK_PATH}/bin"
```
> Hint: to get the flutter sdk path, run this command: 
>	```
>	flutter sdk-path
> ```

#### Install linux requirements:
```
sudo apt install \
	clang \
	cmake \
	ninja-build \
	pkg-config \
	libgtk-3-dev \
	liblzma-dev
```

## Run
```
flutter run --release
```