FROM nvcr.io/nvidia/cuda:12.0.0-base-ubuntu20.04

ARG DEBIAN_FRONTEND=noninteractive

RUN apt update -y && apt upgrade -y && \
    apt install -y \
        build-essential \
        gxmessage \
        libglx0 \
        libglu1-mesa \
        libegl1 \
        libxkbcommon0 \
        libxkbcommon-x11-0 \
        libxcb-icccm4 \
        libxcb-image0 \
        libxcb-keysyms1 \
        libxcb-render-util0 \
        libxcb-* \
        libsm6 \
        libgssapi-krb5-2 \
        libfontconfig1 \
        libglib2.0-0 \
        libopengl0 \
        libnss3 \
        libasound2 \
        libxkbfile1

# install nsight
ARG NSIGHT_INSTALLER=NsightSystems-linux-public-2022.5.1.82-3207805.run
COPY ./${NSIGHT_INSTALLER} /
RUN ./${NSIGHT_INSTALLER} -- -noprompt && \
    rm ./${NSIGHT_INSTALLER}

# add nsight to path
ENV PATH=$PATH:/opt/nvidia/nsight-systems/2022.5.1/bin/

CMD nsys-ui
