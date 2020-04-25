FROM ubuntu:20.04

ARG DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get -y install --no-install-recommends \
	libreoffice-common=* \
	ure \
	libreoffice-java-common \
	openjdk-8-jre \
	fonts-opensymbol \
	hyphen-fr \
	fonts-dejavu \
	fonts-dejavu-core \
	fonts-dejavu-extra \
	fonts-fanwood \
	fonts-freefont-ttf \
	fonts-liberation \
	fonts-lmodern \
	fonts-lyx \
	fonts-sil-gentium \
	fonts-texgyre \
	fonts-tlwg-purisa \
        && rm -rf /var/lib/apt/lists/*

EXPOSE 2002

RUN adduser --system --disabled-password --gecos "" --shell=/bin/bash libreoffice

RUN echo $'[Bootstrap] \n\
HideEula=1 \n\
Logo=0 \n\
NativeProgress=false \n\
ProgressBarColor=222,72,20 \n\
ProgressFrameColor=245,245,245 \n\
ProgressPosition=72,189 \n\
ProgressSize=409,8 \n\
ProgressTextBaseline=170 \n\
ProgressTextColor=255,255,255' > /etc/libreoffice/sofficerc

RUN echo $"#!/bin/bash \n\
exec /usr/bin/libreoffice --nologo --norestore --invisible --headless --accept='socket,host=0,port=2002,tcpNoDelay=1;urp;'" > /usr/local/bin/startlo.sh && chmod a+x /usr/local/bin/startlo.sh

RUN mkdir /tmp/libreoffice && chmod a+rxw /tmp/libreoffice
VOLUME ["/tmp/libreoffice"]

ENTRYPOINT ["startlo.sh"]
