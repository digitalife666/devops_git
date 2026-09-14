# 목차 - 파악에 있어 차질이 빚어졌던(오답 처리된) 내용을 위주로 기술합니다^^.
- 명령어를 사용하여 Shell Script를 작성 및 실행합니다.
- 스크립트의 퍼미션, shebang, 경로 처리 방식을 이해합니다.
- 환경 변수, 조건문을 활용 및 실행 환경을 설정합니다.
- 파이썬 웹 프로그램, Qwen, Ollama로 하여금 로컬 AI 서비스를 실행합니다.

# Qwen, Ollama 관련 복습
- 모델 선택 시 태그를 명확히 지정하여야 합니다. 예) qwen3:0.6b 중 (0.6b는 6억을 일컬음. b는 billion)
- 브라우저 접속 시 표시되는 링크: 'http://localhost:8000'
- 파이썬 웹 앱 사용 시 접속되는 링크(chat.py): '127.0.0.1:8000' (상동)
- Ollama 서버: '127.0.0.1:11434'
- ★ qwen-web 디렉터리에 별도로 모델을 복사 혹은 푸시하지 마십시오. Ollama 측에서 보관합니다.

# Ollama 설치 절차
- 하단 명령어를 사용하여 설치하십시오.
```shell
$ 업데이트
$ sudo apt install -y python3 curl zstd
$ curl -fsSL https://ollama.com/install.sh | sh
```
- 서버 확인을 하십시오.
```shell
$ ollama --version
$ python3 --version
$ curl -fsS http://127.0.0.1:11434/api/tags
$ ollama serve #서버가 응답할 경우 실행하지 않아도 무방
```

# Qwen 절차
- 다운로드 및 리스트 조회
```shell
$ ollama pull qwen3:0.6b(다운받고자 하는 모델은 원하는 대로 작성)
$ ollama list
```

# 웹 브라우저 상에서 열기
```shell
$ cd ~/devops
$ mkdir -p week03/qwen-web
$ cd week03/qwen-web
$ pwd
$ ls
$ python3 chat.py #python 파일 실행
```
- 브라우저 주소란에 'http://localhost:8000/'을 입력하십시오.
- 만일 모델을 변경하고자 한다면, 'nano chat.py'로 해당 파일의 모델을 수정하여야 합니다.

# 쉘 스크립트 작성법 복습
- 앞서 start.sh 파일을 생성합니다.
```shell
$ nano start.sh
```
- 하기한 바와 같이 스크립트를 작성합니다.
```shell
#!/bin/bash  # '#!'은 셔뱅을 뜻합니다. 어느 인터프리터로 실행할는지 OS에 선언하는 코드입니다. (bash로 실행하시오.)
cd "$(dirname "$0")" || exit 1  # "$0" 현재 실행한 스크립트의 이름 혹은 경로, 따옴표로 경로 내 공백 문제 해결.
                                # dirname : 파일 이름을 제외한 파일 경로 중 디렉토리만 출력하는 명령어.
                                # exit : 명령 종료 상태 성공 시 0, 상태 실패 시 0 外, '|| exit 1' : 앞전 명령 실패하여 종료하되, 실패를 뜻하는 코드 1을 잔존시킴.
exec python3 chat.py #bash를 python3로 대체합니다.
```
- 쉘 스크립트 변수 설정에 대하여 다룹니다.
```shell
$ cat > start_with_export.sh << '어느단어든무관' #cat: 입력된 내용 출력, >: 표준 출력 파일로 전송, start_with_export.sh: 저장 대상, <<: heredoc 시작
                                                #'어느단어든무관' 입력 종료를 위한 문자열. 통념적으로 EOF를 사용토록 명명되어 있긴 합니다. 또한 ''를 사용해야 합니다.
```

# 조건문 복습
- 조건문의 기본적인 문법 양태는 다음과 같습니다.
```
if 명령어; then
  실행할 내용
fi
```
- 프로그램 설치 여부 공지 코드 작성 예문입니다.
```shell
if ! command -v python3 >/dev/null 2>&1; then
  echo "Python3를 먼저 설치하십시오." >&2
  exit 1
fi
```
- command -v : 명령어 실행이 될 경우, 경로 확인. 만일 명령어가 없을 시, 실패 상태 반환 및 미출력.
- '>' : 표준 출력을 다른 곳으로 보내는 리다이렉션(자동 이동).
- /dev/null : 리눅스의 특수 장치로서 휴지통 역할. 즉, >/dev/null은 출력 폐기 선언.
- ★ 2>&1 : 표준 오류(2)를 표준 출력(1)의 방향으로 보냅니다. 순서(좌->우 척도)에 기반하여 해석이 판이해집니다.
- 예) 2>&1 >/dev/null : 표준 오류는 표준 출력으로 앞서 설정된 후 표준 출력이 /dev/null로 이동하므로, 에러 메시지는 잔존합니다.
- 예2) >/dev/null 2>&1 : 앞부분 명령어의 표준 출력을 /dev/null로 보낸 후, 표준 오류 역시 표준 출력과 동일한 곳(/dev/null)로 보내어 모든 출력을 소거합니다.
  전술한 두 예시를 요약하건대, 명령어의 순서 배치에 따라 함의하는 바가 달라집니다.
- echo "Python3를 먼저 설치하십시오." >&2 : "Python3를 먼저 설치하십시오." 출력을 오류 메시지(>&2)로 출력하겠다는 의미입니다.

- 다음 테이블을 참고하여 주십시오.

| number | 명칭 |
| :---: | :---: |
| 0 | 표준 입력[stdin] |
| 1 | 표준 출력[stdout] |
| 2 | 표준 오류[stderr] |

# 3주차 복습은 여기까지입니다.
