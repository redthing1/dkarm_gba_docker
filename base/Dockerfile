FROM debian:bullseye-slim

ARG DEVKITPRO=/opt/devkitpro
ENV DEVKITPRO=$DEVKITPRO

# install basic deps
RUN apt update && apt install -y \
    make build-essential wget curl git \
    && apt autoremove -y && apt clean

RUN wget https://apt.devkitpro.org/install-devkitpro-pacman \
  && chmod +x ./install-devkitpro-pacman \
  && sed -i 's/apt-get install/apt-get -y install/g' ./install-devkitpro-pacman \
  && ./install-devkitpro-pacman

# sync dkp pacman
RUN dkp-pacman -Sy
# install packages
RUN dkp-pacman -S --noconfirm gba-dev

# set devkitpro variables
ARG DKP_TOOLS_PATH=$DEVKITPRO/tools/bin
ENV DKP_TOOLS_PATH=$DKP_TOOLS_PATH

WORKDIR /source

ENTRYPOINT [ "bash", "-l" ]