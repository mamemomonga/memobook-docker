#!/bin/bash
set -euo pipefail

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
	sleep infinity & wait
}

case "${1:-}" in
	"server" )
		trap server_stop TERM
		server_start
		;;

	"shell" )
		shift
		exec bash $@	
		;;

	* )
		usage
		;;

esac
