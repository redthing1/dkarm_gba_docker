FROM debian:bullseye

ENV DEVKITPRO /opt/devkitpro
ENV DEVKITARM /opt/devkitarm

RUN apt update && apt install -y \
    make build-essential wget curl
RUN wget https://github.com/devkitPro/pacman/releases/download/v1.0.2/devkitpro-pacman.amd64.deb -O /tmp/dkp_pacman.deb && sudo dpkg -i /tmp/dkp_pacman.deb