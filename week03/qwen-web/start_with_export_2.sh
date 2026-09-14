#!/bin/bash
cd "$(dirname "$0")" || exit 1

if ! command -v python3 > /dev/null 2>&1; then
	echo "Python3를 먼저 설치하십시오." >&2
	exit 1
fi

export WEB_PORT="8080"
exec ./start.sh
