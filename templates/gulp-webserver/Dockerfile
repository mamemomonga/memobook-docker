FROM node:8.9.1-alpine

# 時刻の設定
RUN set -xe && \
	rm /etc/localtime && \
	ln -s /usr/share/zoneinfo/Asia/Tokyo /etc/localtime && \
	echo 'Asia/Tokyo' > /etc/timezone

# su-exec
RUN set -xe && apk add --update su-exec
