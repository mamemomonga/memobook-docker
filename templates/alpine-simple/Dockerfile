FROM alpine:3.6

# 時刻の設定
RUN set -xe && \
	rm /etc/localtime && \
	ln -s /usr/share/zoneinfo/Asia/Tokyo /etc/localtime && \
	echo 'Asia/Tokyo' > /etc/timezone

# su-exec のインストール
# https://github.com/ncopa/su-exec
RUN set -xe && apk add --update su-exec

# ユーザの追加
RUN set -xe && \
	addgroup -g 1001 app && \
	adduser -G app -u 1001 -s /bin/sh -D app

# ファイルの追加
ADD assets/ /

ENTRYPOINT ["/entrypoint.sh"]

