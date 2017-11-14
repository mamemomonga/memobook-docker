# Dockerのセットアップ (Ubuntu 16.04.3 LTS)

* OverlayFS2 を使用する
* dockerデータを別ディスクに設定する

Dockerのインストールとセットアップ

	$ bash -xe << 'END_OF_SCRIPT'
		wget https://get.docker.com -O - | sh
		sudo systemctl stop docker
	 
		CONFIGURATION_FILE=$(systemctl show --property=FragmentPath docker | cut -f2 -d=)
		echo $CONFIGURATION_FILE
		sudo cp $CONFIGURATION_FILE /etc/systemd/system/docker.service
	
		sudo perl -pi -e 's/^(ExecStart=.+)$/$1 -s overlay2/' /etc/systemd/system/docker.service
		sudo systemctl daemon-reload
		sudo systemctl start docker
		sudo docker info 2>&1 | grep 'Storage Driver'
		sudo usermod -a -G docker $USER
	END_OF_SCRIPT

	$ poweroff

新しいディスクを追加する。/dev/xvdf(/dev/sdf)に割り当てるものとする

	$ sudo fdisk /dev/xvdf << 'EOS'
	n
	p
	1


	w
	q
	EOS
	$ sudo mkfs.ext4 /dev/xvdf1
	$ sudo mount /dev/xvdf1 /mnt
	$ sudo e2label /dev/xvdf1 docker
	$ sudo service docker stop
	$ sudo sh -c 'cp -a /var/lib/docker/* /mnt'
	$ sudo rm -rf /var/lib/docker
	$ sudo mkdir /var/lib/docker
	$ sudo sh -c 'echo "LABEL=docker /var/lib/docker ext4 defaults,discard 0 0" >> /etc/fstab'
	$ sudo mount -a
	$ ls /var/lib/docker
	$ sudo service docker start
	$ docker info

Docker Composeのインストール

[こちらで](https://docs.docker.com/compose/install/#install-compose) 最新版を確認する

	$ sudo curl -L https://github.com/docker/compose/releases/download/1.17.0/docker-compose-`uname -s`-`uname -m` -o /usr/local/bin/docker-compose
	$ sudo chmod 755 /usr/local/bin/docker-compose
	$ docker-compose --version

# 参考資料

http://blog.ciplogic.com/index.php/blog/109-docker-with-overlayfs-on-ubuntu-16-04-lts

