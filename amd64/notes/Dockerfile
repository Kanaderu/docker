FROM ubuntu:20.04

ARG DEBIAN_FRONTEND=noninteractive

# setup system packages
USER root
RUN apt-get update -yq && \
    apt-get install -yq curl git pkg-config wget vim unzip apt-utils x11-apps cmake build-essential \
                        automake libtool autoconf libcairo2-dev libpango1.0-dev libglib2.0-dev \
                        libglew-dev libglfw3-dev libgtest-dev \
                        python3 python3-pip python3-dev python3-venv libpython3-dev \
                        libopenblas-dev default-jdk libva-dev libgtk2.0-dev \
                        libtiff-dev zlib1g-dev libjpeg-dev libpng-dev \
                        libavcodec-dev libavformat-dev libswscale-dev libv4l-dev \
                        libxvidcore-dev libx264-dev \
                        ffmpeg libavfilter-extra7 \
                        libatlas3-base libatlas-base-dev libavresample-dev \
                        libgstreamer1.0-0 libgstreamer1.0-dev libgstreamer-plugins-base1.0-dev libgstreamer-plugins-bad1.0-dev gstreamer1.0-plugins-base gstreamer1.0-plugins-good gstreamer1.0-plugins-bad gstreamer1.0-plugins-ugly gstreamer1.0-libav gstreamer1.0-doc gstreamer1.0-tools gstreamer1.0-x gstreamer1.0-alsa gstreamer1.0-gl gstreamer1.0-gtk3 gstreamer1.0-qt5 gstreamer1.0-pulseaudio \
                        libboost-all-dev libboost-regex-dev libusb-1.0-0-dev libeigen3-dev libssl-dev \
                        libpq-dev gdal-bin libgdal-dev \
                        graphviz libgraphviz-dev \
                        libzmq5 libzmqpp-dev && \
    curl -fsSL https://deb.nodesource.com/setup_lts.x | bash - && apt install -y nodejs && \
    apt-get clean && rm -rf /var/lib/apt/lists/* && \
    ln -s /usr/bin/python3 /usr/bin/python

# setup venv and python packages
ARG USER=dev
ENV USER $USER

ARG PYENV=py_env
ENV PYENV $PYENV

SHELL ["/bin/bash", "-c"]

RUN useradd -ms /bin/bash $USER
USER $USER
WORKDIR /home/$USER
COPY ./requirements.txt /
RUN python -m venv $PYENV && \
    source /home/$USER/$PYENV/bin/activate && \
    pip install wheel && \
    pip install -r /requirements.txt --extra-index-url https://download.pytorch.org/whl/cu113 && \
    jupyter lab build

# setup entrypoint
COPY ./entrypoint.sh /
ENTRYPOINT ["/entrypoint.sh"]

# setup app location
WORKDIR /app

# command
CMD ["jupyter", "lab", "--ip", "0.0.0.0", "--allow-root"]
