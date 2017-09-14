FROM debian:latest

# build-essential
RUN set -xe && \
	mv /etc/apt/sources.list /etc/apt/sources.list.orig && \
	sed -e 's/httpredir\.debian\.org/ftp.jp.debian.org/g' /etc/apt/sources.list.orig > /etc/apt/sources.list && \
	apt-get update && \
	DEBIAN_FRONTEND=noninteractive apt-get install -y build-essential

RUN set -xe && \
 	DEBIAN_FRONTEND=noninteractive apt-get install -y openssh-server && \
	sed -ri 's/UsePAM yes/#UsePAM yes/g' /etc/ssh/sshd_config && \
	sed -ri 's/#PasswordAuthentication yes/PasswordAuthentication no/g' /etc/ssh/sshd_config && \
	mkdir -p /var/run/sshd

RUN set -xe && \
	mkdir -p /root/.ssh && \
	chown -R root:root /root  && \
	chmod 700 /root/.ssh

EXPOSE 22
CMD    ["/usr/sbin/sshd", "-D"]
