# alpine linuxをつかったsshdのdocker image, containerを作成する

## 参考URL
* https://wiki.alpinelinux.org/wiki/Setting_up_a_ssh-server
* https://docs.docker.com/engine/examples/running_ssh_service/

## 作業内容

setup.tmpl.sh 参照

## Dockerfileをつかってイメージとコンテナを作成する

make image を実行すると、新たにSSHキーペアを作成し、その公開鍵を登録します。

詳しくは Makefile参照

## 実行例
イメージ、コンテナを作成し、SSHでログインして抜けだして、コンテナを停止してイメージを削除する。

	$ make image
	$ docker images
	$ make container
	$ docker ps
	$ ssh -i ssh/id_rsa -p 22220 root@localhost
	$ exit
	$ make stop
	$ docker ps
	$ make clean
	$ docker ps -a
	$ docker images -a

イメージを作成し、docker hubの[USERNAME]に公開する。

(事前に docker login の実行が必要)

	$ make image
	$ docker tag alpine-sshd:latest [USERNAME]/alpine-sshd:latest
	$ docker push [USERNAME]/alpine-sshd:latest
	$ open https://hub.docker.com/r/[USERNAME]/alpine-sshd/

## ヘルプ

	$ make

だけ実行すると make で利用できるコマンド一覧が表示される。

