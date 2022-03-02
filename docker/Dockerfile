# This is an auto generated Dockerfile for ros:desktop-full
# generated from docker_images/create_ros_image.Dockerfile.em
FROM osrf/ros:kinetic-desktop-xenial


# run container in non-root model - default user: docker
# ==============================================================================================================================
RUN echo 'docker ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers
COPY entrypoint.sh /usr/local/bin/entrypoint.sh

ENV GOSU_VERSION 1.14
RUN set -eux; \
# save list of currently installed packages for later so we can clean up
    savedAptMark="$(apt-mark showmanual)"; \
    apt-get update; \
    apt-get install -y --no-install-recommends ca-certificates wget; \
    if ! command -v gpg; then \
        apt-get install -y --no-install-recommends gnupg2 dirmngr; \
    elif gpg --version | grep -q '^gpg (GnuPG) 1\.'; then \
# "This package provides support for HKPS keyservers." (GnuPG 1.x only)
        apt-get install -y --no-install-recommends gnupg-curl; \
    fi; \
    rm -rf /var/lib/apt/lists/*; \
    \
    dpkgArch="$(dpkg --print-architecture | awk -F- '{ print $NF }')"; \
    wget -O /usr/local/bin/gosu "https://github.com/tianon/gosu/releases/download/$GOSU_VERSION/gosu-$dpkgArch"; \
    wget -O /usr/local/bin/gosu.asc "https://github.com/tianon/gosu/releases/download/$GOSU_VERSION/gosu-$dpkgArch.asc";  

# verify the signature
RUN export GNUPGHOME="$(mktemp -d)"; \
    gpg --batch --keyserver hkps://keys.openpgp.org --recv-keys B42F6819007F00F88E364FD4036A9C25BF357DD4; \
    gpg --batch --verify /usr/local/bin/gosu.asc /usr/local/bin/gosu; \
    command -v gpgconf && gpgconf --kill all || :; \
    rm -rf "$GNUPGHOME" /usr/local/bin/gosu.asc; 

RUN apt-mark auto '.*' > /dev/null; \
    [ -z "$savedAptMark" ] || apt-mark manual $savedAptMark; \
    apt-get purge -y --auto-remove -o APT::AutoRemove::RecommendsImportant=false; \
    \
    chmod +x /usr/local/bin/gosu; 

RUN gosu --version; \
    gosu nobody true

RUN chmod +x /usr/local/bin/entrypoint.sh
ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]
# ==============================================================================================================================

# Build Essentials
# ==============================================================================================================================
 RUN apt-get update && apt-get install -y \
     software-properties-common \
     build-essential \
     && rm -rf /var/lib/apt/lists/*
# ==============================================================================================================================

# CUDA & OPENGL
# ==============================================================================================================================
RUN apt-get update && apt-get install -y --no-install-recommends ca-certificates apt-transport-https gnupg-curl && \
    rm -rf /var/lib/apt/lists/* && \
    NVIDIA_GPGKEY_SUM=d1be581509378368edeec8c1eb2958702feedf3bc3d17011adbf24efacce4ab5 && \
    NVIDIA_GPGKEY_FPR=ae09fe4bbd223a84b2ccfce3f60f4b3d7fa2af80 && \
    apt-key adv --fetch-keys https://developer.download.nvidia.com/compute/cuda/repos/ubuntu1604/x86_64/7fa2af80.pub && \
    apt-key adv --export --no-emit-version -a $NVIDIA_GPGKEY_FPR | tail -n +5 > cudasign.pub && \
    echo "$NVIDIA_GPGKEY_SUM  cudasign.pub" | sha256sum -c --strict - && rm cudasign.pub && \
    echo "deb https://developer.download.nvidia.com/compute/cuda/repos/ubuntu1604/x86_64 /" > /etc/apt/sources.list.d/cuda.list && \
    echo "deb https://developer.download.nvidia.com/compute/machine-learning/repos/ubuntu1604/x86_64 /" > /etc/apt/sources.list.d/nvidia-ml.list

ENV CUDA_VERSION 10.0.130

ENV CUDA_PKG_VERSION 10-0=$CUDA_VERSION-1

#ENV CUDA_VERSION 9.0.176
#ENV CUDA_PKG_VERSION 9-0=$CUDA_VERSION-1

RUN apt-get update && apt-get install -y --no-install-recommends \
        cuda-cudart-$CUDA_PKG_VERSION && \
    ln -s cuda-10.0 /usr/local/cuda && \
    rm -rf /var/lib/apt/lists/*

RUN echo "/usr/local/nvidia/lib" >> /etc/ld.so.conf.d/nvidia.conf && \
    echo "/usr/local/nvidia/lib64" >> /etc/ld.so.conf.d/nvidia.conf

ENV PATH /usr/local/nvidia/bin:/usr/local/cuda/bin:${PATH}
ENV LD_LIBRARY_PATH /usr/local/nvidia/lib:/usr/local/nvidia/lib64

# nvidia-container-runtime
ENV NVIDIA_VISIBLE_DEVICES all
ENV NVIDIA_DRIVER_CAPABILITIES compute,utility
ENV NVIDIA_REQUIRE_CUDA "cuda>=10.0"


# From nvidia cuda 9.0 runtime: https://gitlab.com/nvidia/cuda/blob/ubuntu16.04/9.0/runtime/Dockerfile

ENV NCCL_VERSION 2.4.8

RUN apt-get update && apt-get install -y --no-install-recommends \
        cuda-libraries-$CUDA_PKG_VERSION \
        cuda-cublas-$CUDA_PKG_VERSION \
        libnccl2=$NCCL_VERSION-1+cuda10.0 && \
        apt-mark hold libnccl2 && \
        rm -rf /var/lib/apt/lists/*

# From nvidia cuda 9.0 devel: https://gitlab.com/nvidia/cuda/blob/ubuntu16.04/9.0/devel/Dockerfile

RUN apt-get update && apt-get install -y --no-install-recommends \
        cuda-libraries-dev-$CUDA_PKG_VERSION \
        cuda-nvml-dev-$CUDA_PKG_VERSION \
        cuda-minimal-build-$CUDA_PKG_VERSION \
        cuda-command-line-tools-$CUDA_PKG_VERSION \
        cuda-core-$CUDA_PKG_VERSION \
        cuda-cublas-dev-$CUDA_PKG_VERSION \
        libnccl-dev=$NCCL_VERSION-1+cuda10.0 && \
    rm -rf /var/lib/apt/lists/*

ENV LIBRARY_PATH /usr/local/cuda/lib64/stubs

# Support for Nvidia docker v2

RUN apt-get update && apt-get install -y --no-install-recommends \
        pkg-config \
        libxau-dev \
        libxdmcp-dev \
        libxcb1-dev \
        libxext-dev \
        libx11-dev && \
    rm -rf /var/lib/apt/lists/*
COPY --from=nvidia/opengl:1.0-glvnd-runtime-ubuntu16.04 \
  /usr/local/lib/x86_64-linux-gnu \
  /usr/lib/x86_64-linux-gnu
COPY --from=nvidia/opengl:1.0-glvnd-runtime-ubuntu16.04 \
  /usr/local/share/glvnd/egl_vendor.d/10_nvidia.json \
  /usr/local/share/glvnd/egl_vendor.d/10_nvidia.json
RUN echo '/usr/local/lib/x86_64-linux-gnu' >> /etc/ld.so.conf.d/glvnd.conf && \
    ldconfig
RUN apt-get update
# nvidia-container-runtime
ENV NVIDIA_VISIBLE_DEVICES \
    ${NVIDIA_VISIBLE_DEVICES:-all}
ENV NVIDIA_DRIVER_CAPABILITIES \
    ${NVIDIA_DRIVER_CAPABILITIES:+$NVIDIA_DRIVER_CAPABILITIES,}graphics
# ==============================================================================================================================

# CARLA
# ==============================================================================================================================
ENV CARLA_ROOT /opt/carla-simulator
RUN mkdir -p $CARLA_ROOT

RUN apt-get update && apt-get install -y \
    python-pip && \
    rm -rf /var/lib/apt/lists/*
RUN sudo apt-get update && apt-get install curl
RUN curl -o $CARLA_ROOT/CARLA_0.9.11.tar.gz -SL "https://carla-releases.s3.eu-west-3.amazonaws.com/Linux/CARLA_0.9.11.tar.gz"
RUN tar -zxf $CARLA_ROOT/CARLA_0.9.11.tar.gz -C $CARLA_ROOT && rm $CARLA_ROOT/CARLA_0.9.11.tar.gz

RUN curl -o $CARLA_ROOT/Import/AdditionalMaps_0.9.11.tar.gz -SL "https://carla-releases.s3.eu-west-3.amazonaws.com/Linux/AdditionalMaps_0.9.11.tar.gz"
RUN cd $CARLA_ROOT && ./ImportAssets.sh

# ==============================================================================================================================


# ROS
# ==============================================================================================================================
RUN sudo sh -c 'echo "deb http://packages.ros.org/ros/ubuntu $(lsb_release -sc) main" > /etc/apt/sources.list.d/ros-latest.list'
RUN apt-get -y update
RUN apt-get install -y curl
RUN curl -s https://raw.githubusercontent.com/ros/rosdistro/master/ros.asc | sudo apt-key add -
RUN apt-get update && apt-get install -y \
    ros-kinetic-desktop-full=1.3.2-0* \
    libpng16-16 \
    libproj-dev \
    ros-kinetic-ackermann-msgs \
    ros-kinetic-tf \
    ros-kinetic-cv-bridge \
    ros-kinetic-pcl-conversions \
    ros-kinetic-pcl-ros \
    ros-kinetic-ainstein-radar* \
    ros-kinetic-velodyne \
    ros-kinetic-velodyne-pointcloud \
    python-catkin-tools \
    ros-kinetic-jsk-rviz-plugins \
    ros-kinetic-plotjuggler \
    && rm -rf /var/lib/apt/lists/*

# Workaround related to carla ros bridge issue with latest version of some packages.
# As a workaround we use a snapshot of the ROS apt repository to install an older version of the required
# packages.
RUN sudo rm -f /etc/apt/sources.list.d/ros1-latest.list
RUN sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-key 4B63CF8FDE49746E98FA01DDAD19BAB3CBF125EA
RUN sudo sh -c 'echo "deb http://snapshots.ros.org/kinetic/2020-08-06/ubuntu $(lsb_release -sc) main" >> /etc/apt/sources.list.d/ros-snapshots.list'
RUN sudo apt-get update && sudo apt-get install -y --no-install-recommends \
        ros-kinetic-ackermann-msgs \
        ros-kinetic-derived-object-msgs \
    && sudo rm -rf /var/lib/apt/lists/*
# ==============================================================================================================================

# GCC 7
# ==============================================================================================================================
RUN add-apt-repository ppa:ubuntu-toolchain-r/test
RUN apt-get update && apt-get install -y \
     g++-7 \
     && rm -rf /var/lib/apt/lists/*
RUN update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-7 60 \
                         --slave /usr/bin/g++ g++ /usr/bin/g++-7
RUN update-alternatives --config gcc

# UPGRADE PYGAME
# ==============================================================================================================================
RUN pip install --upgrade pygame
# ==============================================================================================================================

# CARLA SCENARION RUNNER
# ==============================================================================================================================
RUN pip install --upgrade pip==20.3.4 && pip install --no-cache-dir pexpect py_trees==0.8.3 networkx==2.2 psutil shapely xmlschema==1.0.18 \
    filelock ephem transforms3d tabulate subprocess32
RUN apt-get update && apt-get install -y \
    git \
    && rm -rf /var/lib/apt/lists/*
# ==============================================================================================================================

# SETUP ENVIROMENT VARIABLES
# ==============================================================================================================================
ENV SCENARIO_RUNNER_PATH /home/hitachi/hitGit/had-sim/ext_repos/scenario-runner
ENV SCENARIO_RUNNER_ROOT /home/hitachi/hitGit/had-sim/ext_repos/scenario-runner
ENV ROOT_SCENARIO_RUNNER /home/hitachi/hitGit/had-sim/ext_repos/scenario-runner
ENV HIT_SCENARIO_PATH /home/hitachi/hitGit/had-sim/hit_ros_bridge/hit_carla_scenarios/hit-scenarios
# ==============================================================================================================================

RUN add-apt-repository ppa:deadsnakes/ppa && apt-get update \
    && sudo apt-get install -y python3.7 \
    python3-pip  \
    && rm -rf /var/lib/apt/lists/*

RUN python3.7 -m pip install scenariogeneration==0.5.0

# DEV

# Jetbrains dependencies
RUN apt-get update && apt-get install -y \
    libcanberra-gtk-module \
    libcanberra-gtk3-module \
    libnss3 \
    && rm -rf /var/lib/apt/lists/*

RUN apt-get update && apt-get install -y \
    tmux \
    && rm -rf /var/lib/apt/lists/*

RUN pip install pandas

RUN apt-get update && apt-get install -y \
    ffmpeg \
    && rm -rf /var/lib/apt/lists/*