# DockerをDebian(Jessie)上に構築し、docker-machineでMacから使用する

https://docs.docker.com/engine/installation/linux/debian/

* Debian側にはSSH公開鍵でログインできること
* MacにはDocker for Macを導入済み
* パスワードなしでsudoでrootになれるユーザを用意する(docker-machine createではそのユーザで接続する)

## Debianでの作業

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

