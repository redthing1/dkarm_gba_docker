FROM debian:bullseye

ARG DEVKITPRO=/opt/devkitpro
ENV DEVKITPRO=$DEVKITPRO

# install deps
RUN apt update && apt install -y \
    make build-essential wget curl git cmake

# install dlang
RUN wget https://s3.us-west-2.amazonaws.com/downloads.dlang.org/releases/2021/dmd_2.098.0-0_amd64.deb -O /tmp/dlang_dmd.deb && apt install -y /tmp/dlang_dmd.deb
RUN apt install -y ldc

# install dkp pacman
RUN wget https://github.com/devkitPro/pacman/releases/download/v1.0.2/devkitpro-pacman.amd64.deb -O /tmp/dkp_pacman.deb && apt install -y /tmp/dkp_pacman.deb

# sync dkp pacman
RUN dkp-pacman -Sy
# install packages
RUN dkp-pacman -S --noconfirm gba-dev

# install my custom tools
ARG DKP_TOOLS_PATH=$DEVKITPRO/tools/bin
ENV DKP_TOOLS_PATH=$DKP_TOOLS_PATH

# install crunch
RUN git clone https://github.com/redthing1/crunch.git /tmp/crunch && cd /tmp/crunch \
    && mkdir build && cd build && cmake .. && make -j$(nproc) && cp crunch_gen $DKP_TOOLS_PATH

# install tiled2gba
RUN git clone https://github.com/redthing1/Tiled2GBA.git /tmp/tiled2gba && cd /tmp/tiled2gba/converter \
    && mkdir build && cd build && cmake .. && make -j$(nproc) && cp Tiled2GBA $DKP_TOOLS_PATH

# install nelua
RUN git clone https://github.com/edubart/nelua-lang.git /tmp/nelua-lang && cd /tmp/nelua-lang \
    && make && make install

WORKDIR /source

ENTRYPOINT [ "bash", "-l" ]