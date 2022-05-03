# Docker Build for ROS Kinetic

## Prerequisites

1. Ubuntu PC (16.04 or later) with NVIDIA GPU (1080 or newer).
2. Install NVIDIA drivers:
	```bash
	sudo add-apt-repository ppa:graphics-drivers/ppa
	sudo apt update
	sudo apt install nvidia-driver-435 # or later
	sudo reboot
	```
3. Install [Docker](https://docs.docker.com/install/linux/docker-ce/ubuntu/):
	```bash
	sudo apt-get remove docker docker-engine docker.io containerd runc
	sudo apt-get install apt-transport-https ca-certificates curl gnupg-agent software-properties-common
	curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
	sudo apt-key fingerprint 0EBFCD88
	sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
	sudo apt update
	sudo apt-get install docker-ce
	```
4. Install [NVIDIA-Docker](https://github.com/NVIDIA/nvidia-docker):
	```bash
	curl -s -L https://nvidia.github.io/nvidia-docker/gpgkey | sudo apt-key add -
	curl -s -L https://nvidia.github.io/nvidia-docker/$(. /etc/os-release;echo $ID$VERSION_ID)/nvidia-docker.list | sudo tee /etc/apt/sources.list.d/nvidia-docker.list
	sudo apt-get update
	sudo apt-get install -y nvidia-docker2
	sudo pkill -SIGHUP dockerd
    	sudo usermod -aG docker $USER
	```
-----------------------------------------------------------------------------------------------------------

## Usage

### Cloning the repository
Use the following when cloning the repository:
```
git clone --recursive https://github.com/holmech-dev/docker-builds.git
```

### Building the Docker Image
```bash
cd ~/chris/holmech-dev/docker-builds
./build.sh
```

### Running a container
```bash
cd ~/chris/holmech-dev/docker-builds
./run.sh
```
To instantiate another session of a container already running
```bash
./exec.sh
```
