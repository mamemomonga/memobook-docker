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

# 自分のディレクトリ
BASEDIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# Dockerコンテナ名
DCNTR=alpine-example

# Dockerイメージ名
DCIMG=$DCNTR

# Docker Named Volume
DCVOL=$DCNTR

# Docker run 追加オプション
# Named Volumeがなければ自動的に作成される
DCOPT="-v $DCVOL:/volume/data"

# コマンド一覧
COMMANDS="once up down root app tail rmvol"

# 使い方
function usage {
	echo "USAGE: $0 [ COMMAND ]"
	echo "COMMANDS:"
	for i in $COMMANDS; do
		echo "  $i"
	done
	exit 1
}

# do_[コマンド名] を実行
if [ -z "${1:-}" ]; then usage; fi
for i in $COMMANDS; do
	if [ "$i" == "$1" ]; then
		RUNCOMMAND="do_"$i
		if [ "$(type -t "$RUNCOMMAND")" ]; then
			shift
			$RUNCOMMAND $@
			exit 0
		fi
	fi
	usage
done

