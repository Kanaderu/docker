FROM nvcr.io/nvidia/l4t-tensorrt:r8.4.1-runtime

ARG DEBIAN_FRONTEND=noninteractive

USER root
RUN apt update -y && apt install -y \
        curl \
        cmake \
        git \
        x11-apps \
        libgtk2.0-dev \
        libgl1 \
        python3 python3-dev && \
    curl -fsSL https://deb.nodesource.com/setup_lts.x | bash - && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

# setup python packages
COPY ./requirements.txt /
RUN ln -s /usr/local/bin/pip /usr/bin/pip && \
    pip install --no-cache-dir wheel setuptools && \
    pip install --no-cache-dir -r /requirements.txt --use-deprecated=legacy-resolver

CMD ["jupyter", "lab", "--ip", "0.0.0.0", "--port", "8888", "--allow-root", "--no-browser", "--NotebookApp.token=''"]
