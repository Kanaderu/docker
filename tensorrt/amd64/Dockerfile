FROM nvcr.io/nvidia/tensorrt:22.12-py3

ARG DEBIAN_FRONTEND=noninteractive

USER root
RUN apt update -y && apt install -y \
        curl \
        x11-apps \
        libgtk2.0-dev \
        libgl1 \
        libcudart10.1 && \
    curl -fsSL https://deb.nodesource.com/setup_lts.x | bash - && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

# setup venv and python packages
COPY ./requirements.txt /
RUN pip install --no-cache-dir wheel setuptools && \
    pip install --no-cache-dir -r /requirements.txt
#RUN jupyter lab build --dev-build=False

CMD ["jupyter", "lab", "--ip", "0.0.0.0", "--port", "8888", "--allow-root", "--no-browser", "--NotebookApp.token=''"]
