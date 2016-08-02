# alpine linuxをつかったsshdのdocker image, containerを作成する

## 参考URL
* https://wiki.alpinelinux.org/wiki/Setting_up_a_ssh-server
* https://docs.docker.com/engine/examples/running_ssh_service/

## 作業内容

setup.tmpl.sh 参照

## Dockerfileをつかってイメージとコンテナを作成する

~/.ssh/id_rsa.pubが登録され、そのキーでログインできる。

詳しくは Makefile参照

## 実行例
イメージ、コンテナを作成し、SSHでログインして抜けだして、コンテナを停止してイメージを削除する。

	$ make image
	$ make container
	$ ssh -p 22220 root@localhost
	$ exit
	$ make stop
	$ make clean

## ヘルプ

	$ make

だけ実行すると make で利用できるコマンド一覧が表示される。
