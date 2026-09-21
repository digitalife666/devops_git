# 목차 - 간단하게 요약하였습니다...
- grep, find, |(파이프)에 대한 개념을 확립합니다.
- 자동화를 위한 쉘 스크립트를 작성합니다.
- 브랜치 -> PR -> Conflict 해결 -> Merge의 협업 흐름을 수행합니다.

# '$'에 대하여... (경로에 대한 이야기)
- 만일 쉘 스크립트에서 경로를 호출할 경우, cd "$(dirname "$0")"를 사용한 경우를 보았다면,
- 이것은 스크립트를 어디서 호출하든 간에 스크립트의 위치를 기준으로 실행하기 위함일 것입니다.

# |, grep에 대한 실제 명령어
- 하단 명령어를 보시겠습니다.
```shell
$ grep -R -n "exit 1" week03 2>/dev/null #exit 1을 포함하는 파일 찾기
                                         #-R: 하위 디렉토리까지 모두 검색
                                         #-n: 줄 번호 표시
                                         #exit 1을 포함하는 파일 개수 현시
$ grep -R -n "exit 1" week03 2>/dev/null | wc -l  #wc -l: 입력 텍스트의 줄 수 계산
```
- | 파이프: 파일 전달 혹은 or의 의미가 아닌,
  앞전 명령의 표준 출력을 뒤 명령의 표준 입력으로 연결하는 것입니다.

# head, tail, wc 에 대하여...
- head: 출력하고자 하는 파일의 앞부분 출력
- tail: 출력하고자 하는 파일의 뒷부분 출력
- wc: word count
```shell
$ head -2 ??? #앞 2줄 출력
$ tail -1 ??? #뒷 1줄 출력
$ wc -l ??? #전체 줄수 출력
```

# 변수와 명령 치환
- 변수 및 날짜 출력에 관한 쉘 스크립트 작성문입니다.
```shell
$ cat > var.sh << 'EOF'
> #!/bin/bash
> USERNAME="홍길동"
> TODAY=$(date +%Y%m%d)
> echo "이름: $USERNAME"
> echo "파일명: backup_${TODAY}.tar.gz"
> EOF
$ chmod u+x var.sh && ./var.sh
```
- 해당 스크립트를 작성할 때 주의하여야 할 점이 있습니다.
- 예컨대, USERNAME = "name"은 잘못된 예이며, USERNAME="name"이 올바른 예입니다.
- 더불어, echo USERNAME이 아닌, echo "$USERNAME"이어야 합니다. $가 없을 시 문자열 그대로 출력됩니다.

# 인자와 종료 코드
- 만일 사용 절차가 잘못되어 스크립트가 실행됨에 있어 오류가 있다면,
- ```$ echo $?```를 입력하였을 때 1이 출력되지만,
- 만일 실행에 있어 오류가 없다면, 0이 출력됩니다.

# 반복문
- 반복문의 기본적인 문법 양태는 다음과 같습니다.
```bash
$ for i in $(seq 1 100); do mkdir -p test/dir$i; done #디렉토리 100개 생성
$ for f in *.sh; do echo "스크립트: $f"; done #스크립트 파일 모두 출력
```

# 프로세스 관련 간단 이야기
- ps aux: 시스템에서 실행 중인 거의 모든 프로세스를 상세하게 보여줍니다.
```bash
$ ps aux | head -5 # 프로세스 정보 앞 5줄
$ ps aux | grep bash # bash를 포함하는 프로세스
```

# tar, diff에 대한 이해
### tar: 여러 파일을 하나의 아카이브로 묶는 도구입니다.
- -tzf: 내용 확인 (t=list(목록 확인), z=gzip(압축 사용), f=뒤에 오는 파일명 지정)
- -xzf: 압축 해제 (x=extract(압축 해제), z=gzip(압축 사용), f=뒤에 오는 파일명 지정)
- -czf: 압축 생성 (c=create(생성), z=gzip(압축 사용), f=뒤에 오는 파일명 지정)
- -C: Change directory (작업할 디렉토리 지정)
### diff -rq
- diff는 differences의 약자이며, 지정된 두 파일 사이의 내용을 비교하는 명령어입니다.
- 이때 rq의 r은 recursive(재귀), q는 brief(간결한) 모드를 뜻합니다.

# Git에 올리지 말 것.
- 4주차 디렉토리 내의 backups 디렉토리 및 파일은 절대로 Git에 등록하지 말아야 합니다.
- 이때, .gitignore에 지정한 파일을 작성하여 Git 대상에서 제외되도록 합니다.
```
$ cd ~/devops/
$ cat >> .gitignore << 'EOF'
> week04/backups/
> week04/restore-check/
> EOF
$ git add .gitignore
$ git add week04
$ git commit -m "week04: 백업 스크립트 초안"
$ git push
```

# 브랜치?
- 쉽게 말하자면, 마블 시네마틱 유니버스의 '멀티버스'와 같은 개념입니다.
```
main           ●───●───●────────────● <- 기준이 되는 안정적인 브랜치
                     \             /
feature/backup-log ●───●───●─────── <- 내 작업실 (터져도 main은 안전)
```
- 브랜치에 대한 실습 코드 예제입니다.
```bash
$ cd ~/devops
$ git branch # 현재 브랜치 확인
* main
$ git switch -c feature/backup-log # 브랜치 생성
Switched to a new branch 'feature/backup-log'
$ git branch # 현재 브랜치 확인 (2개 확인 및 브랜치 변경 확인)
```
