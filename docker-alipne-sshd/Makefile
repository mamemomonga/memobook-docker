
# 埋め込む公開鍵
SSH_PUBKEY=$(HOME)/.ssh/id_rsa.pub

# 作成するイメージ
DCR_IMAGE=alpine-sshd:latest

# 作成するコンテナ
DCR_CONTAINER=alpine-sshd-01

# 使い方
usage:
	@echo ""
	@echo "IMAGE"
	@echo "   make image     create docker image"
	@echo "   make export    export docker image to tar archive"
	@echo "   make import    import from tar archive to docker image"

	@echo "CONTAINER"
	@echo "   make container create docker container and start"
	@echo "   make start     start docker container"
	@echo "   make shell     enter shell"
	@echo "   make stop      stop docker container"
	@echo "   make commit    create image from container"

	@echo "CLEANUP"
	@echo "   make clean     stop docker container and destroy container, image"
	@echo ""

# setup.shの作成
setup.sh: setup.tmpl.sh
	sed -e 's;###AUTHORIZED_KEYS###;$(shell cat $(SSH_PUBKEY));g' $< > $@

# イメージの作成
image: setup.sh
	docker build -t $(DCR_IMAGE) .

# コンテナの作成
container:
	docker run -d -p 22220:22 --name=$(DCR_CONTAINER) $(DCR_IMAGE)

# コンテナの起動
start:
	docker start $(DCR_CONTAINER)

# コンテナの停止
stop:
	docker stop $(DCR_CONTAINER)

# シェルの起動
shell:
	docker exec -it $(DCR_CONTAINER) /bin/sh

# コンテナからイメージを作成する
commit:
	docker commit $(DCR_CONTAINER) $(DCR_CONTAINER):latest

# コンテナからファイルへエクスポートする
export:
	docker export $(DCR_CONTAINER) > $(DCR_CONTAINER).tar

# ファイルからコンテナへインポートする
import:
	docker import $(DCR_CONTAINER).tar $(DCR_CONTAINER):imported

# 削除
clean:
	-rm setup.sh
	-docker stop $(DCR_CONTAINER)
	-docker rm  -f $(DCR_CONTAINER)
	-docker rmi -f $(DCR_IMAGE)

