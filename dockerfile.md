# Dockerfileメモ

[Dockerfileリファレンス](http://docs.docker.jp/engine/reference/builder.html)

## よく使うコマンドメモ

#### [FROM](http://docs.docker.jp/engine/reference/builder.html#from)

ソースイメージ

	FROM alpine:3.6

#### [ENV](http://docs.docker.jp/engine/reference/builder.html#env)

環境変数

	ENV KEY=VALUE

#### [RUN](http://docs.docker.jp/engine/reference/builder.html#run)

処理、set -xe は shオプション、レイヤー数を軽減するため1行で実行するため && でつなげる。\ は折り返し。

	RUN set -xe && \
		uname -a > /uname.txt && \
		rm /uname.txt

#### [ADD](http://docs.docker.jp/engine/reference/builder.html#add)

ファイル追加、フォルダ一括追加やtarアーカイブ展開機能があるので、単一ファイルの追加の明示する場合はCOPYのほうがよい。

	ADD assets/ /

#### [ENTRYPOINT](http://docs.docker.jp/engine/reference/builder.html#entrypoint)

コンテナが実行するプログラム。
docker run 時の引数が渡される。

#### [CMD](http://docs.docker.jp/engine/reference/builder.html#cmd)

コンテナが実行するデフォルトプログラム。
docker run 時の引数が渡された場合そのプログラムが実行される。

## Dockerimage

* [alpine:3.6](https://hub.docker.com/_/alpine/)
* [debian:jessie](https://hub.docker.com/_/debian/)
* [ubuntu:xenial](https://hub.docker.com/_/ubuntu/)
* [centos:6](https://hub.docker.com/_/centos/)

* [perl:5.26](https://hub.docker.com/_/perl/)
* [node:8](https://hub.docker.com/_/node/)
* [python:3](https://hub.docker.com/_/python/)
* [python:2](https://hub.docker.com/_/python/)

## 日本時間にする

	RUN set -xe && \
		rm /etc/localtime && \
		ln -s /usr/share/zoneinfo/Asia/Tokyo /etc/localtime && \
		echo 'Asia/Tokyo' > /etc/timezone

## パッケージのインストールとクリーンアップ

一つのレイヤー内でファイルを削除すれば、イメージの肥大化を回避できる

## Alpine

## Debian系(Debian, Ubuntu)

### RedHat系(CentOS, Amazon Linux)

## gosu

sudo の代わりに使うと複数階層化を軽減できる。

https://github.com/tianon/gosu
