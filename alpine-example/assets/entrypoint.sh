#!/bin/sh
set -eu

function usage {
	echo "USAGE: $0 [ server | shell ]"
	exit 1
}

function server_stop {
	echo ""
	echo "SERVER STOP"
	exit 0
}

function server_start {
	echo "SERVER START"

	# 無限に待機したい
	# https://stackoverflow.com/questions/2935183/bash-infinite-sleep-infinite-blocking

	# Debianなどではsleep infinityが使える
	# sleep infinity & wait

	# Alpineのbusyboxのsleepにはinfinityがないので、catとpipeで代用
	mkfifo /tmp/infinity-wait && cat /tmp/infinity-wait & wait

}

case "${1:-}" in
	"server" )
		trap server_stop TERM
		server_start
		;;

	"shell" )
		shift
		exec sh $@	
		;;

	* )
		usage
		;;

esac
