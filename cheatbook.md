# Dockerチートブック

## イメージ

### build
カレントディレクトリのDockerfileから the-image イメージを作成する

	docker build --tag the-image .

### images
イメージの一覧を表示する

	docker images

### rmi
imagename イメージを削除する

	docker rmi the-image

### save
イメージを圧縮しながらアーカイブに保存する

	docker save the-image | gzip -c -9 > the-image.tar.gz

### load
イメージを圧縮されたアーカイブから復元する

	cat the-image.tar.gz | gunzip -c -9 | docker load

## コンテナ

### run

the-image イメージから the-container コンテナを作成し、デーモンとして起動する

	docker run --name the-container --detach the-image

### すべてのコンテナを削除

	docker ps -a | awk '{ print $1 }' | sed '1d' | xargs docker rm -f

