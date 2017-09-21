# Dockerチートブック

## 基本的な考え方





## イメージ

### build
カレントディレクトリのDockerfileから the-image イメージを作成する

	$ docker build --tag the-image .
	$ docker build -t the-image .

### images
イメージの一覧を表示する

	$ docker images

### rmi
imagename イメージを削除する

	$ docker rmi the-image

### save
イメージを圧縮しながらアーカイブに保存する

	$ docker save the-image | gzip -c -9 > the-image.tar.gz

### load
イメージを圧縮されたアーカイブから復元する

	$ cat the-image.tar.gz | gunzip -c -9 | docker load

## コンテナ

### run

the-image イメージから the-container コンテナを作成し、デーモンとして起動する

	$ docker run --name the-container --detach the-image
	$ docker run --name the-container -d the-image

the-image イメージから the-container コンテナを作成し、バックグラウンドで起動し、
起動する80/TCPをローカルホストの8000/TCPで公開し、/dataをカレントディレクトリのdataフォルダと共有する

	$ docker run -p 8000:80 -v $(pwd)/data:/data -d --name the-container the-image

### stop, start, rm

the-container 停止

	$ docker stop the-container

the-container 起動

	$ docker start the-container

the-container 削除

	$ docker rm the-container

### inspect

the-containerのIPアドレスを取得する

	$ docker inspect --format="{{ .NetworkSettings.IPAddress }}" the-container

### すべてのコンテナを削除

	$ docker ps -a | awk '{ print $1 }' | sed '1d' | xargs docker rm -f

### 終了したコンテナを削除

	$ docker ps -a -f 'exited=0' --format '{{ .ID }}' | xargs docker rm

### ダグのないイメージを削除

	$ docker images -f 'dangling=true' --format '{{ .ID }}' | xargs docker rmi
	
## docker-machine

現在参照しているDOCKER_HOSTのIPアドレスを取得する

	$ echo $DOCKER_HOST | sed -e 's/^tcp:\/\///' -e 's/:[0-9]*$//'

