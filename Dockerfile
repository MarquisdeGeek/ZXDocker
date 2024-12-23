FROM ubuntu:22.04
LABEL Version="1.0" \
      Date="2024-Feb-24" \
      Docker_Version="Docker version 25.0.3, build 4debf41" \
      Vendor="em.ulat.es" \
      Maintainer="Steven Goodwin - Marquis de Geek (@marquisdeGeek)" \
      Description="A basic Docker container to compile and use ZX Spectrum tools"

ARG   USER_NAME=user
ARG   USER_PASSWORD=${USER_NAME}
ARG   USER_PATH=/home/${USER_NAME}


# Create a non-root user
RUN useradd -ms /bin/bash $USER_NAME && echo "$USER_NAME:$USER_PASSWORD" | chpasswd && adduser $USER_NAME sudo


# Base OS and tools
RUN apt-get update && \
    apt-get install -y wget unzip git tcc sudo vim && \
    apt-get remove --purge --auto-remove -y


# The ZX env
USER $USER_NAME
RUN cd $USER_PATH && \
    mkdir -p zx && \
    mkdir -p zx\zx81 && \
    mkdir -p zx\zxspectrum


# Emu: zesarux
USER root
RUN apt-get update && \
    apt-get install -y spectemu-common spectemu-x11 spectrum-roms zmakebas libxxf86vm1 libsdl1.2debian && \     
    apt-get remove --purge --auto-remove -y

USER $USER_NAME
RUN cd $USER_PATH/zx && \
    mkdir contrib && cd contrib && \
    wget -O zx.tar.gz https://github.com/chernandezba/zesarux/releases/download/ZEsarUX-X/ZEsarUX_linux-X-ubuntu22_x86_64.tar.gz && \
    tar zfx zx.tar.gz && \
    rm zx.tar.gz

COPY zx/emu/zesarux/rc /$USER_PATH/.zesaruxrc


# BASIC text to .p (81)
RUN cd $USER_PATH/zx/contrib && \
    git clone https://github.com/tomwhite/zxtext2p.git && \
    tcc -lm zxtext2p/zxtext2p.c -o zxtext2 && \
    rm -rf zxtext2p && \
    mv zxtext2 zxtext2p

    

# Asm: pasmo (81 & Spectrum)
USER root
RUN apt-get -y install pasmo && \     
    apt-get remove --purge --auto-remove -y


# Our glue tools
USER $USER_NAME
COPY zx/machines/zx81/tools /$USER_PATH/zx81
COPY zx/machines/zxspectrum/tools /$USER_PATH/zxspectrum

WORKDIR $USER_PATH/zx/machines

# Keeps the container open
CMD [ "/bin/bash" ]

