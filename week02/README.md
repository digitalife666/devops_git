# 목차 - 파악에 있어 차질이 빚어졌던(오답 처리된) 내용을 위주로 기술합니다^^.
- 서버와 가상화
- WSL2 리눅스 환경
- 리눅스 터미널 (파일, Dir, 퍼미션, 기초 명령어)
- Git으로 하여금 커밋, 버전 관리, 브랜치 학습
- GitHub로 공유 (gh를 활용)

# 가상화 서버 복습 (베어메탈)
- 베어메탈(Bare Metal)이란? PC 한 대에 OS 설치 뒤 여러 소프트웨어를 운영하는 방식입니다.
- 하나의 OS에서 모든 프로그램을 관장하기 용이하되, 한 개의 프로그램 해킹 시, 기타 프로그램도 위험해집니다.

# 리눅스 관련...
- ★ 리눅스 컨테이너의 기술 중 '프로세스, 파일 시스템, 네트워크 등의 격리를 담당하는 기술'의 명칭은 "namespace"입니다.
- ★ 더불어 중요시되고 있는 기술 중 'CPU, MEM 등의 리소스 사용량 제어를 관장하는 기술'의 명칭은 "cgroups"입니다.
- WSL은 인터넷 연결 없이도 로컬에서 사용 가능합니다. 빠른 속도, 시스템 통합, 편리성 등의 장점이 있지요.
- 만일 특정 버전의 우분투를 설치하고 싶다면, 하단의 명령어를 입력하면 됩니다.
```shell
wsl --install -d ubuntu-version.here
wsl -l -v
wsl --set-version Ubuntu-version.here
```

- 과거 리눅스 CLI 사용 중 미처 터득하지 못했던 유용한 명령어 몇 가지를 정리해봅니다.
```shell
whoami #접속 후 계정 조회
cd - #앞전에 작업하던 디렉토리로 이동
rmdir <directory> #공백 디렉토리 삭제

cat 'example' > 'example' #앞의 파일 내용 결합하여 파일에 기록
cat 'example' >> 'example' #앞의 파일 내용에 결부하여 파일에 추가

!13 #history 내의 13번째 명령어 실행
!13:p #history 내의 13번째 명령어 내용 조회(프린트)
!! #직전의 명령어 재실행 (sudo 문제로 유용히 사용 중^^)
!ls #앞전의 ls로 시작된 명령어 재실행
```

# Git 관련...
- 기본 프로파일 설정에 대하여 다룹니다.
```git
git config --global user.name "이름" #사용자 이름 여기에...
git config --global user.email "이메일" #사용자 이메일 여기에...
git config --global init.defaultBranch main #기본 브랜치 명을 'main'으로 설정하겠다는 의미...
```

- 깃 초기화 방법 (매우 중요합니다!!!)
```git
cd DirPathHere #초기화 할 디렉터리로 이동
git init #깃이 버전을 관리하는 dir로 초기화(dir 재확인 필수)
git status #깃 상태 조회 (처음 입력 시: 'On branch main... No commits yet... ' 문구가, 새 파일 생성 후 입력 시: 'Untracked files: example.???')
```

- 깃 파일 추가, 커밋 메시지 추가, 로그 조회, 한 줄 요약 로그 조회
```git
git add fileNameHere
git commit -m "commit name here"
git log
git log --oneline
```

- 깃 특정 파일 지정, 수정된 모든 파일 지정
```git
git add example.???
git add .
```

- 깃 버전 관리
```git
git switch -d <commit hash value here> #커밋 변경(커밋 해시의 버전으로 변경), 커밋 구별 가능 수준의 앞자리만 취사 입력(7자리)
git diff <commit hash01> <commit hash02> #각 커밋 변경 사항 비교. 출력된 내용의 +, - 표시로 말미암아 비교 용이
```

- 깃 브랜치 명령어
```git
git switch -c <branch_name> #브랜치 만들기
git switch <branch_name> #브랜치 이동
git branch #현재 브랜치 조회
```

# GitHub에 대하여.
- gh를 사용하여 GitHub와 연결할 수 있습니다.
- gh --version을 통하여 설치 여부 조회가 가능합니다.
- GitHub 로그인 절차입니다.
```
$ gh auth login
? What account do you want to log into? GitHub.com
? What is your preferred protocol for Git operations on this host? HTTPS
? Authenticate Git with your GitHub credentials? Yes
? How would you like to authenticate GitHub CLI? Login with a web browser

! First copy your one-time code: ????-????
Press Enter to open github.com in your browser...
```
- 만일 오류 발생 시, wslview를 설치(install wslu)하여 연결을 완료할 수도 있습니다.
- gh를 사용하여 허브와 연결하는 과정입니다.
```
pwd #현재 디렉토리 확인 (매우 중요)
gh repo create <repo_name> --public --source=. --remote=origin --push #리포지토리 생성
gh repo view --web #웹으로부터 리포지토리 조회
git commit -m "message"
git push #커밋 이후 반드시 push 하시기 바랍니다.
```
- 용어 설명
```
gh repo create <repo_name> --public --source=. --remote=origin --push
▪ <레포이름>
  • 생성할 GitHub repository 이름
• --public
  • 공개 저장소로 생성
▪ --source=.
  • 현재 디렉터리를 원본으로 사용 → 현재 디렉토리의 Git 저장소를 GitHub에 연결
▪ --remote=origin
  • 원격 저장소 이름 지정
▪ origin
  • 연결된 원격 저장소에 관례적으로 사용하는 이름
▪ --push
  • 로컬의 커밋을 원격 저장소에 업로드
```

# 2주차 내용 복습은 여기까지입니다.
