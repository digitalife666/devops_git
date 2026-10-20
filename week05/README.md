# 5주차 - Docker에 관하여...

# 목차 - 파악에 있어 차질이 빚어졌던 내용을 위주로 기술하였습니다^^.
- 이미지와 컨테이너의 명확한 관계를 파악합니다.
- docker run, ps, logs, exec, stop, rm, images 등의 커맨드 옵션을 이해합니다.
- GitHub Issue, Issue-Branch-Pull, Request-Merge 절차를 이해합니다.

# 도커(Docker)란 무엇인가?
- 애플리케이션 실행 환경 자체를 컨테이너란 개념으로 분류하여, 타 환경에서도 동일하게 실행하도록 설계된 플랫폼입니다.
- 참고로, 별도의 가상 OS를 설치하는 하이퍼바이저와 달리 도커는 커널 자체를 공유합니다.

# 도커의 구성요소 4가지.
- Image: 컨테이너를 생성하기 위한 읽기 전용 템플릿입니다.
- Container: 상기한 이미지로 하여금 생성된 인스턴스(Instance)입니다.
- Dockerfile: 이미지를 어떻게 구성할 것인지를 작성하는 파일입니다.
- Registry: 이미지를 저장 및 공유하는 공간입니다. 이를테면 Docker Hub가 이에 해당합니다.

# 이미지와 컨테이너에 대한 더욱 소상한 비교.
- 붕어빵에 대한 비유로 풀이하자면, 이미지는 붕어빵 프레임이며, 컨테이너는 제조된 붕어빵이라고 볼 수 있습니다.
- 즉, 이미지는 컨테이너를 제조하기 위한 일종의 외연이라고도 할 수 있지요.
- 다시 말해, 팥 붕어빵을 만들고, 해당 팥 붕어빵을 폐기한 뒤 다시 새로운 붕어빵을 제조하면 앞전의 붕어빵은 존재하지 않습니다.
- 이미지 하나를 가지고 여러 개의 컨테이너를 생성할 수 있다는 것이지요.
- 또한, 이미지는 프로그램, 실행 환경을 압축한 파일입니다. 이미지로 컨테이너 실행 시, 격리된 환경이 생성되고, 그 내부의 프로그램이 프로세스로 실행됩니다.

# 도커 명령어 모음.
- docker run 명령어 예) ```$ docker run -d -p 8080:80 --name container_name image_name```
  '-d': detached(백그라운드 실행), '-p': publish: 후술한 포트로 연결, '--name': 컨테이너 이름 지정, 마지막에 이미지 명을 기입합니다.
- docker rm 명령어 예) ```$ docker rm -f name_here``` name_here라는 컨테이너를 정리합니다. -f는 강제 삭제입니다.
- docker ps 명령어 예) ```$ docker ps```는 실행 중인 컨테이너 목록을, ```$ docker ps -a```는 정지된 컨테이너를 포함한 모든 컨테이너 목록을 현시합니다.
- docker images 명령어 예) ```$ docker images```는 내려받기한 이미지 목록을 조회합니다.
- docker logs 명령어 예) ```$ docker logs container_name```는 지금까지의 로그를 현시하나, ```$ docker logs -f container_name```는 실시간으로 확인합니다. 이때 -f는 --follow를 의미합니다.
- docker stop 명령어 예) ```$ docker stop container_name```는 도커를 정지시킵니다. 즉, ps 명령어 입력 시 목록에서 제외됩니다.
- docker start & restart 명령어 예) start는 시작하기, restart는 멈춘 뒤 시작합니다.
- docker exec 명령어 예) ```$ docker exec -it container_name bash```를 해석하자면, 특정 컨테이너 내부에서 쉘을 실행하겠다는 의미입니다. -i는 interactive요, -t는 (tty)입니다.

# GitHub Issue에 대한 설명.
- Issue란 무엇인가? 무엇을, 왜 하여야 하는지에 대하여 기록 및 진행 상황을 관리하는 협업 도구입니다. 비단 오류만을 기재하는 곳은 아님을 유념하여야 합니다.
- 그 외 Issue와 관련된 내용을 정리하였습니다.
  ```
  Issue: 무엇을, 왜 할 것인가?
  Branch: 해당 작업을 안전하게 진행하는 공간.
  Pull Request: 변경된 내용 검토 및 병합을 요청
  Merge: 변경된 내용을 반영. 단어 그대로 병합.
  ```
  
# 다음으로, 이슈 내용을 작성합니다.
  ## 목표
  Docker 실행 환경 확인 및 nginx 컨테이너 실행
  ## 완료 조건
  - [v] `docker --version` 정상 출력
  - [v] `docker run hello-world` 실행
  - [v] `web`이라는 이름으로 nginx 컨테이너 실행
  - [v] 브라우저 또는 `curl`로 `http://localhost:8080` 응답 확인
  - [v] `docker ps`에서 실행 상태를 확인
  - [v] 실습 결과를 `week05/README.md`에 기록
  - [v] 수업에서 만든 컨테이너 정리
  - [v] 혼자서 해보기 완료

# 작성이 완료되었다면, 이슈 작업 브랜치를 생성하여야 합니다.
- 메인 최신 유지
  ```
  $ git switch main
  $ git pull --ff-only
  ```
- 변수에 이슈 번호 저장
  ```
  $ ISSUE_NO=number #사이트에서 확인하여야...
  ```
- 작업 브랜치 생성
  ```
  $ git switch -c "docs/issue-${ISSUE_NO}-docker-start" #브랜치 명에 이슈 번호는 생략 가능.
  $ git branch
  * docs/issue-6-docker-start
  main
  ```
  
# commit, push 및 pull request 생성합니다.
- 커밋과 푸시를 하는 과정.
  ```
  $ git status
  $ git add ~/devops/week05/
  $ git commit -m "5주차: Docker 실행 환경 및 nginx 확인 (#${ISSUE_NO})"
  $ git push -u origin "docs/issue-${ISSUE_NO}-docker-start"
  ```
- Pull Request.
  ```
  $ gh pr create --title "5주차: Docker" --body "Close #${ISSUE_NO}
  > ## 작업 내용
  > - Docker 실행 환경 확인
  > - hello-world 실행
  >
  > ## 검증
  > - docker ps -a
  > - curl -I http://localhost:8080"
  ```

# Merge 완료 후 Issue 종료를 확인합니다.
```
$ gh pr merge --squash --delete-branch
$ git switch main  # main 브랜치로 이동
$ git pull --ff-only
$ gh issue view "$ISSUE_NO" --json state -q .state  # 또는 웹사이트에서 직접 확인
```

# 5주차 복습은 여기까지입니다.
- 4주차 역시 README가 있었으나, 모종의 실수로 파일이 날아가버렸습니다. 다만 평가상 최소 3개이므로, 2, 3, 5주차 정도로 마무리하겠습니다. 감사합니다.
