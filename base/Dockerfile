FROM debian:sid-slim

ARG DEVKITPRO=/opt/devkitpro
ENV DEVKITPRO=$DEVKITPRO

# install basic deps
RUN apt update && apt install -y \
    make build-essential wget curl git

# install dkp pacman
RUN wget https://github.com/devkitPro/pacman/releases/download/v1.0.2/devkitpro-pacman.amd64.deb -O /tmp/dkp_pacman.deb && apt install -y /tmp/dkp_pacman.deb

# sync dkp pacman
RUN dkp-pacman -Sy
# install packages
RUN dkp-pacman -S --noconfirm gba-dev

# set devkitpro variables
ARG DKP_TOOLS_PATH=$DEVKITPRO/tools/bin
ENV DKP_TOOLS_PATH=$DKP_TOOLS_PATH

WORKDIR /source

ENTRYPOINT [ "bash", "-l" ]