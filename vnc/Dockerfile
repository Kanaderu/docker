FROM ubuntu:20.04

# ubuntu and settings setup
ARG DEBIAN_FRONTEND=noninteractive
ARG TZ=America/New_York
ENV LC_ALL C.UTF-8
ENV LANG en_US.UTF-8

# display setup
ENV DISPLAY :0
ENV GEOMETRY 1920x1080
ENV DEPTH 16
EXPOSE 5900

# setup timezone
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

RUN apt-get update -y && apt-get install -y \
        curl wget x11-apps build-essential git vim default-jre \
        xterm tightvncserver libxtst-dev libxrender-dev xfce4 xfce4-goodies \
        novnc python3-websockify python3-numpy \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

ENV USER=root
ENV RESET_VNC=true

RUN cp /usr/share/novnc/vnc.html /usr/share/novnc/index.html

RUN apt-get update -y && apt-get install -y lxqt lxde \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

COPY start.sh /
CMD [ "/start.sh" ]


