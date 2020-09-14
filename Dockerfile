FROM lsiobase/ubuntu:focal
LABEL maintainer="RandomNinjaAtk"

ENV TITLE="Automated Music Downloader (AMD)"
ENV TITLESHORT="AMD"
ENV VERSION="1.0.12"
ENV MBRAINZMIRROR="https://musicbrainz.org"
ENV XDG_CONFIG_HOME="/config/deemix/xdg"
ENV DOWNLOADMODE="wanted"

## DEFAULT ENVS
ENV DOWNLOADS="/downloads-amd"
ENV AUTOSTART="true"
ENV SCRIPTINTERVAL="1h"
ENV DOWNLOADMODE="wanted"
ENV LIST="both"
ENV SEARCHTYPE="both"
ENV CONCURRENCY=1
ENV FORMAT="FLAC"
ENV BITRATE=320
ENV REQUIREQUALITY="false"
ENV MATCHDISTANCE=10
ENV REPLAYGAIN="true"
ENV FOLDERPERMISSIONS=766
ENV FILEPERMISSIONS=666

RUN \
	echo "************ install dependencies ************" && \
	echo "************ install packages ************" && \
	apt-get update -y && \
	apt-get upgrade -y && \
	apt-get install -y --no-install-recommends \
		gcc-arm-linux-gnueabihf \
		libc6-dev \
		jq \
		mp3val \
		flac \
		opus-tools \
		eyed3 \
		ffmpeg \
		python3 \
		python3-pip && \
	rm -rf \
		/tmp/* \
		/var/lib/apt/lists/* \
		/var/tmp/* && \
	echo "************ install python packages ************" && \
	python3 -m pip install --no-cache-dir -U \
		yq \
		mutagen \
		r128gain \
		deemix && \
	echo "************ setup dl client config directory ************" && \
	echo "************ make directory ************" && \
	mkdir -p "${XDG_CONFIG_HOME}/deemix"
	
# copy local files
COPY root/ /

# set work directory
WORKDIR /config

# ports and volumes
VOLUME /config
