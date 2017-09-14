# Ubuntu 17.04 での Dockerセットアップ

	$ wget https://get.docker.com -O - | sh
	$ sudo systemctl stop docker
	 
	$ CONFIGURATION_FILE=$(systemctl show --property=FragmentPath docker | cut -f2 -d=)
	$ echo $CONFIGURATION_FILE
	$ sudo cp $CONFIGURATION_FILE /etc/systemd/system/docker.service
	
	$ sudo perl -pi -e 's/^(ExecStart=.+)$/$1 -s overlay2/' /etc/systemd/system/docker.service
	$ sudo systemctl daemon-reload
	$ sudo systemctl start docker
	$ sudo docker info 2>&1 | grep 'Storage Driver'
	$ sudo usermod -a -G docker $USER

再ログイン

	$ docker info
	$ docker ps -a
	
### 参考URL
http://blog.ciplogic.com/index.php/blog/109-docker-with-overlayfs-on-ubuntu-16-04-lts

