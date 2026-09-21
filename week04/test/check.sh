#!/bin/bash
FILE="$1"
if [ -z "$FILE" ]; then
  echo "파일명을 입력:"; exit 1
fi
if [ -f "$FILE" ]; then
  echo "파일"
elif [ -d "$FILE" ]; then
  echo "디렉토리"
else
  echo "존재하지 않음."; exit 1
fi
