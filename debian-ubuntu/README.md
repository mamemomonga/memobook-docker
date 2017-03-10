# docker-engineのインストール

## Ubuntu Xenial 16.04 (LTS)

https://docs.docker.com/engine/installation/linux/ubuntu/

### DockerCEのインストール

	sudo apt remove docker docker-engine
	sudo apt install \
	    apt-transport-https \
	    ca-certificates \
	    curl \
	    software-properties-common
	curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
	sudo apt-key fingerprint 0EBFCD88
	sudo add-apt-repository \
	   "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
	   $(lsb_release -cs) stable"
	sudo apt update
	sudo apt install docker-ce
	sudo docker info

## Debian jessie 8.4

https://docs.docker.com/engine/installation/linux/debian/

### インストール(若干情報が古いです)

	sudo sh -c 'cat > /etc/apt/sources.list.d/backports.list' << 'EOS'
	deb http://ftp.jp.debian.org/debian jessie-backports main
	EOS

	sudo sh << 'EOS'
	set -xe
	aptitude update
	aptitude install apt-transport-https ca-certificates
	apt-key adv --keyserver hkp://p80.pool.sks-keyservers.net:80 --recv-keys 58118E89F3A912897C070ADBF76221572C52609D
	EOS

	sudo sh -c 'cat > /etc/apt/sources.list.d/docker.list' << 'EOS'
	deb https://apt.dockerproject.org/repo debian-jessie main
	EOS

	sudo sh << 'EOS'
	set -xe
	aptitude update
	apt-cache policy docker-engine
	aptitude update
	aptitude install -y docker-engine
	service docker start
	EOS

## sudoなしに docker コマンドを実行できるようにする

Debuan,Ubuntu共通

https://docs.docker.com/engine/installation/linux/debian/#/giving-non-root-access

	bash << 'EOS'
	if [ -z $(getent group docker) ]; then
	  sudo groupadd docker
	fi
	sudo gpasswd -a $USER docker
	sudo service docker restart
	exec $SHELL
	EOS

	いったんexitして再ログインする

	docker info

## docker-compose, docker-machineのインストール

Debuan,Ubuntu共通

* https://docs.docker.com/compose/install/
* https://docs.docker.com/machine/install-machine/

最新のを自動でいれたいので jqをいれる。もっといい方法あるのかもしれない

クライアント側で利用するものなので、サーバとして利用するだけならば不要

	sudo bash << 'EOS'
	 set -e
	 apt-get -y install jq
	 for i in compose machine; do
	   TAGNAME=$(curl -Ls https://api.github.com/repos/docker/$i/releases/latest | jq -r '.tag_name')
	   URL=https://github.com/docker/$i/releases/download/$TAGNAME/docker-$i-`uname -s`-`uname -m`
	   echo "docker-$i TAG: $TAGNAME"
	   echo "docker-$i URL: $URL"
	   curl -L $URL > /usr/local/bin/docker-$i
	   chmod +x /usr/local/bin/docker-$i
	   docker-$i -v
	 done
	EOS


# docker-machineでdebian,ubuntu上のdockerをMacから使用する

* Debian,Ubuntu側にはSSH公開鍵でログインできること
* MacにはDocker for Macを導入済み
* パスワードなしでsudoでrootになれるユーザを用意する(docker-machine createではそのユーザで接続する)

## Macでの作業

項目               | 内容
-------------------|-------------------
DebianのIPアドレス | 192.168.0.10
SSH秘密鍵のパス    | $HOME/.ssh/id_rsa
ユーザ名           | admin
SSHのポート番号    | 22
設定の名前         | docker-debian

### 例

	docker-machine create \
	  --driver generic \
	  --generic-ip-address=192.168.0.10 \
	  --generic-ssh-key=$HOME/.ssh/id_rsa \
	  --generic-ssh-user=admin \
	  --generic-ssh-port=22 \
		docker-debian

### docker-machine env

dockerコマンドは環境変数でターゲットを切り替えられる。
docker-machineはターゲットを切り替えるための環境変数をはき出してくれる。

#### 確認

	docker-machine env docker-debian

#### 利用

	eval $(docker-machine env docker-debian)

#### 解除

	eval $(docker-machine env --unset)

