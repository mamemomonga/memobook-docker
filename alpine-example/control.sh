#!/bin/bash
set -euo pipefail

# 起動・終了をコントロールするスクリプト

function do_build {
	echo "[DOCKER BUILD]"
	docker build -t $DCIMG $BASEDIR
}

function do_once {
	do_build
	echo "[DOCKER RUN ONCE]"
	exec docker run $DCOPT -it --rm $DCIMG shell
}

function do_up {
	do_build
	do_down
	echo "[DOCKER RUN]"
	docker run $DCOPT -d --name $DCNTR $DCIMG server
	sleep 1
	docker ps -a --filter "name=$DCNTR"
}

function do_down {
	echo "[DOCKER STOP]"
	docker stop $DCNTR || true 
	echo "[DOCKER RM]"
	docker rm   $DCNTR || true 
}

function do_tail {
	exec docker logs -f $DCNTR 
}

function do_remove_volume {
	echo "[DOCKER REMOVE NAMED VOLUME]"
	exec docker volume rm $DCVOL
}

function do_root {
	exec docker exec -it $DCNTR sh
}

function do_app {
	exec docker exec -it $DCNTR gosu app sh
}

# ----------------------

BASEDIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# Dockerコンテナ名
DCNTR=alpine-example

# Dockerイメージ名
DCIMG=alpine-example

# Docker Named Volume
DCVOL=alpine-example

# Docker run 追加オプション
# Named Volumeがなければ自動的に作成される
DCOPT="-v $DCVOL:/volume/data"

function usage {
	echo "USAGE: $0 [ once | up | down | root | app | tail | rmvol ]"
	exit 1
}

case "${1:-}" in
	"once"  ) do_once  ;;
	"up"    ) do_up    ;;
	"down"  ) do_down  ;;
	"tail"  ) do_tail  ;;
	"rmvol" ) do_remove_volume ;;
	"root"  ) do_root  ;;
	"app"   ) do_app   ;;
	*       ) usage    ;;
esac

