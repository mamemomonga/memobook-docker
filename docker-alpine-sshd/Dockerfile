FROM alpine:latest
MAINTAINER mamemomonga
COPY setup.sh /tmp/
RUN sh /tmp/setup.sh && rm /tmp/setup.sh
EXPOSE 22
CMD ["/usr/sbin/sshd","-D"]
