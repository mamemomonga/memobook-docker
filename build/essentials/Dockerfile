FROM debian:latest

# build-essential
RUN set -xe && \
	mv /etc/apt/sources.list /etc/apt/sources.list.orig && \
	sed -e 's/httpredir\.debian\.org/ftp.jp.debian.org/g' /etc/apt/sources.list.orig > /etc/apt/sources.list && \
	apt-get update && \
	DEBIAN_FRONTEND=noninteractive apt-get install -y build-essential

