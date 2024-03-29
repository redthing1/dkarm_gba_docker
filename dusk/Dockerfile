FROM debian:bookworm-slim

ARG DEVKITPRO=/opt/devkitpro
ENV DEVKITPRO=$DEVKITPRO

# install basic deps
RUN apt update && apt install -y \
    # for building
    build-essential cmake \
    # for scripting
    bash curl wget git \
    # for Python 3
    python3 python3-pip \
    # for devkitpro
    dpkg \
    # clean up
    && apt autoremove -y && apt clean

RUN ln -s /usr/bin/python3 /usr/bin/python

# install dkp pacman
RUN wget https://apt.devkitpro.org/install-devkitpro-pacman \
  && chmod +x ./install-devkitpro-pacman \
  && sed -i 's/apt-get install/apt-get -y install/g' ./install-devkitpro-pacman \
  && ./install-devkitpro-pacman

# Fix the missing /etc/mtab
RUN ln -s /proc/mounts /etc/mtab
# sync dkp pacman
RUN dkp-pacman -Sy
# install packages
RUN dkp-pacman -S --noconfirm gba-dev

# set devkitpro variables
ARG DKP_TOOLS_PATH=$DEVKITPRO/tools/bin
ENV DKP_TOOLS_PATH=$DKP_TOOLS_PATH

# install my custom tools

# install crunch
RUN git clone https://github.com/redthing1/crunch.git /tmp/crunch && cd /tmp/crunch \
    && mkdir build && cd build && cmake .. && make -j$(nproc) && cp crunch_gen $DKP_TOOLS_PATH

# install tiled2gba
RUN git clone https://github.com/redthing1/Tiled2GBA.git /tmp/tiled2gba && cd /tmp/tiled2gba/converter \
    && mkdir build && cd build && cmake .. && make -j$(nproc) && cp Tiled2GBA $DKP_TOOLS_PATH

# install nelua
RUN git clone https://github.com/edubart/nelua-lang.git /tmp/nelua-lang && cd /tmp/nelua-lang \
    && make && make install

# install dlang
# RUN wget https://downloads.dlang.org/releases/2022/dmd_2.100.2-0_amd64.deb -O /tmp/dlang_dmd.deb && apt install -y /tmp/dlang_dmd.deb
RUN curl -fsS https://dlang.org/install.sh | bash -s install ldc-1.30.0 \
  && echo "source ~/dlang/ldc-1.30.0/activate" >> ~/.bashrc

WORKDIR /source

# Add the entrypoint script to the Docker image
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

# Set the entrypoint to the script
ENTRYPOINT ["/entrypoint.sh", "bash", "-l"]
