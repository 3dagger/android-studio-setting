# android-studio-setting

어느 기기에서나 같은 Android Studio 개인 설정(키맵·Live Template·색 테마·글꼴·편집기)을 쓰기 위한 저장소입니다.
설정 폴더를 통째로 올리지 않고 `files.txt` 에 적은 것만 담습니다. macOS·Linux 에서 동작합니다.

프로젝트 설정(코드 스타일·Run Configuration 등)은 여기가 아니라 각 프로젝트 저장소가 맡습니다.

## 담긴 설정

원본은 `config/` 입니다. `./export.sh` 로 설정이 바뀌면 이 목록도 함께 고칩니다.

| 분류 | 요약 | 파일 |
|---|---|---|
| [키맵](#키맵--macos-copy) | `macOS copy` — 단축키 32개 지정, 기본 단축키 40개 해제 | `keymaps/`, `options/mac/keymap.xml` |
| [Live Template](#live-template) | 주석 4개, 쓰지 않는 언어의 기본 템플릿 끔 | `templates/` |
| [코드 스타일·검사](#코드-스타일검사) | Kotlin 공식 스타일, import·XML 속성 순서 | `codestyles/`, `inspection/` |
| [테마·글꼴](#테마글꼴) | UI 테마 Gerry Storm(Gerry Themes 플러그인), 글꼴 크기 12 | `options/laf.xml`, `options/*-font.xml` |
| [편집기](#편집기) | 공백 표시, Kotlin 타입 힌트, VCS 작성자 표시 | `options/editor.xml`, `options/parameter.hints.xml` |
| [화면·동작](#화면동작) | Compact 밀도, 확인 창 줄이기 | `options/ui.lnf.xml`, `options/ide.general.xml` … |
| [메모리·플러그인](#메모리플러그인) | 힙 8GB, 플러그인 5개 | `studio.vmoptions`, `plugins.txt` |

### 키맵 — `macOS copy`

macOS 10.5+ 키맵을 바탕으로 아래만 바꿨습니다. ⌘ Command · ⌥ Option · ⌃ Control · ⇧ Shift

| 분류 | 단축키 | 동작 |
|---|---|---|
| 도구 창 | ⌘L | Logcat |
| | ⌘0 | Running Devices |
| | ⌘2, ⌥F12 | Terminal |
| | ⌘⌥G | Gemini |
| | ⌘; | Logcat·콘솔 비우기 |
| 이동 | ⌘⌥← / ⌘⌥→ (마우스 4·5번 버튼) | 뒤로 / 앞으로 |
| | ⌃R | 최근 파일 |
| | ⌘[ / ⌘] | 이전 / 다음 탭 |
| | ⌘E | 탭을 오른쪽으로 옮기기 |
| | ⌘G | 지금 탭만 남기고 닫기 |
| | ⌘\ | 같은 버전과 비교 |
| 편집 | ⌘⌫, ⌘Y | 줄 지우기 |
| | ⌘→, End | 줄 끝으로 |
| | ⌥← / ⌥→ | 이전 / 다음 단어 |
| | ⌃⌥O, ⌃⌘1 | import 정리 |
| | ⌃⌘P | 대소문자 바꾸기(String Manipulation 플러그인) |
| 새로 만들기 | ⌘' | Kotlin 파일 |
| | ⌘⌥' | XML 레이아웃 |
| | ⌘⌥P | 폴더 |
| | ⌘6 | Vector Asset |
| 빌드·실행 | ⌘3 | Clean Project |
| | ⌥9 | Make Project |
| | ⌘4 | Run |
| | ⌃⌘E | Apply Changes and Restart Activity |
| | ⇧⌃⌘E, ⌃E | Apply Code Changes |
| VCS | ⌃M | 커밋 메시지 기록 |

예전 키맵 `Mac OS X copy` 도 들어 있지만 쓰지 않습니다.

### Live Template

모두 Kotlin·Java 에서 씁니다.

| 약어 | 펼친 결과 |
|---|---|
| `cmtClass` | 클래스 주석 — 패키지·파일 이름·날짜·작성자·버전 |
| `_methodComment` | 메서드 주석 — 설명·작성자·`@return`·`@param` |
| `_todo` | 날짜가 붙은 `TODO ::` 주석 |
| `_suppressComment` | `@suppress` 제외 대상 주석 |

C/C++·CMake·Objective-C·Shell Script·Zen HTML·Zen XSL 의 기본 템플릿 318개는 꺼 두었습니다.

### 코드 스타일·검사

- Kotlin: 공식 스타일(`KOTLIN_OFFICIAL`)
- 들여쓰기 자동 감지 끔
- Java import: static import 를 먼저 모으고, 일반 import 는 `android` · `androidx` · `com` · `junit` · `net` · `org` · `java` · `javax` · 나머지 순서로 그룹마다 빈 줄
- XML 속성 순서: `xmlns:android` → `xmlns:*` → `id` → `name` → `style` → 나머지(이름순·Android 속성 순서), 이어지는 줄 들여쓰기 4
- 검사: Markdown 의 깨진 파일 링크를 경고

### 테마·글꼴

| 항목 | 값 |
|---|---|
| UI 테마 | Gerry Storm(Gerry Themes 플러그인) |
| 편집기 글꼴 | 크기 12(글꼴 이름은 IDE 기본) |
| 터미널 글꼴 | 크기 12 |

Editor Color Scheme 은 담지 않습니다. Gerry Storm 테마를 고르면 같은 이름의 편집기 색 구성도 함께 바뀝니다.
플러그인 없이 켜면 테마를 찾지 못해 기본 테마로 돌아가니, 새 기기에서는 플러그인을 설치한 뒤 Settings > Appearance & Behavior > Appearance > Theme 에서 Gerry Storm 을 다시 고릅니다.

### 편집기

- 공백 문자 표시
- 콘솔·미리보기에서 자동 줄바꿈
- 애매하지 않은 import 는 자동 추가
- 자동완성 때 파라미터 이름 힌트
- Code Vision: VCS 작성자만, 줄 오른쪽에
- 인레이 힌트: Kotlin 타입(변수·프로퍼티·파라미터·반환형), 람다 수신자·반환값, 메서드 체인, Compose 상태 읽기
- 파라미터 이름 힌트에서 `LiveData.observe(owner, observer)` 제외

### 화면·동작

- 밀도 Compact, 제목 표시줄에 전체 경로, 새 탭은 끝에 열기
- 상태 표시줄에 메모리 표시
- 같은 스택트레이스를 합치지 않음
- 시작 팁·종료 확인 끔, 마지막 프로젝트를 다시 열지 않음
- 실행 중인 프로세스가 있는 프로젝트를 닫을 때 연결만 끊기, 다시 실행할 때 종료 확인 끔
- 파일 선택은 macOS 기본 창
- 프로젝트 창: 고른 파일을 바로 편집기에 열기, 빈 중간 패키지도 따로 보이기
- 터미널: Option 을 Meta 키로, Esc 가 편집기로 포커스를 옮기지 않음
- Quick List `3dagger`: Local History

### 메모리·플러그인

- 힙 최대 8GB(`-Xmx8192m`)
- 플러그인(`plugins.txt` — ID 만 담고 설치는 직접)

  | ID | 이름 |
  |---|---|
  | `com.jetbrains.gerryPurpleTheme` | Gerry Themes |
  | `cn.yiiguxing.plugin.translate` | Translation |
  | `com.developerphil.adbidea` | ADB Idea |
  | `com.github.deeepamin.gitlabciaid` | CI Aid for GitLab |
  | `com.suusan2go.kotlin-fill-class` | kotlin-fill-class |

키맵의 ⌃⌘P(String Manipulation)는 지금 설치되지 않은 플러그인의 단축키입니다. 플러그인이 없으면 무시됩니다.

## 새 기기에서

1. Android Studio 를 설치하고 한 번 실행했다가 **종료**합니다(설정 폴더가 생깁니다).
2. 받아서 바뀔 것을 보고 넣습니다.
   ```bash
   git clone https://github.com/3dagger/android-studio-setting.git ~/android-studio-setting
   cd ~/android-studio-setting
   ./import.sh --dry-run
   ./import.sh
   ```
3. 끝에 나오는 플러그인(`plugins.txt`)을 Settings > Plugins > Marketplace 에서 설치하고, 테마를 다시 고릅니다([테마·글꼴](#테마글꼴)).

덮이거나 지운 파일은 `backup/<설정 폴더>-<시각>/` 에 남습니다(커밋하지 않습니다).

## 기기 사이 동기화

집 Mac·회사 PC 어디서든 바꾸고 올릴 수 있습니다. 순서만 지킵니다.

**받기** — 다른 기기에서 올린 설정을 이 기기에 넣습니다.

```bash
git pull --rebase
./import.sh --dry-run   # 바뀔 것: + 새로, ~ 바뀜, - 지움
./import.sh             # Android Studio 를 끈 상태에서
```

**올리기** — 이 기기에서 바꾼 설정을 올립니다. **pull 보다 export 가 먼저**입니다.

```bash
./export.sh
git diff
git add -A && git commit -m "..."
git pull --rebase       # 다른 기기의 변경과 합칩니다
./import.sh             # pull 로 받은 변경이 있으면
git push
```

- pull 만 하고 import 하지 않은 채 export 하면 받은 변경을 되돌리게 됩니다. 기기마다 마지막으로 맞춘 `config/` 의 지문을 `.git/android-studio-sync` 에 두고, `export.sh` 가 이를 보고 멈춥니다. 처음 쓰는 기기도 import 를 한 번 한 뒤에 export 할 수 있습니다.
- Android Studio 는 설정을 바로 저장하지 않을 수 있으니, 바꾼 직후라면 창을 한 번 벗어나거나 종료한 뒤 내보냅니다.
- Claude Code 에게 맡기면 이 저장소의 `CLAUDE.md` 순서(차이를 먼저 보여 주고 확인받기)를 따릅니다.

## 동작

- 설정 폴더는 버전마다 따로 생깁니다(`~/Library/Application Support/Google/AndroidStudio2026.2.1`, Linux 는 `~/.config/Google/…`). 두 스크립트 모두 가장 높은 버전 폴더를 고르고, 다른 폴더는 인자로 줍니다: `./import.sh <설정 폴더>`.
- `export.sh` 는 `config/` 를 매번 새로 채웁니다. 지운 설정도 diff 에 나옵니다.
- `import.sh` 는 IDE 를 `config/` 에 맞춥니다. `files.txt` 범위 안에서 저장소에 없는 파일은 IDE 에서도 지웁니다(다른 기기에서 지운 설정이 살아나지 않게). 범위 밖 파일은 건드리지 않습니다. Android Studio 가 켜져 있으면 멈춥니다(종료할 때 메모리의 설정으로 다시 덮어쓰기 때문입니다). `--dry-run` 은 켜져 있어도 됩니다.
- 심볼릭 링크를 쓰지 않습니다. IDE 가 설정 파일을 새로 쓰면서 링크가 일반 파일로 바뀔 수 있습니다.
- `studio.vmoptions` 는 Toolbox 가 넣는 줄(`-Dide.managed.by.toolbox`·`-Dtoolbox.notification.*` — 기기별 토큰·경로)을 빼고 담고, 넣을 때는 그 기기의 Toolbox 줄을 남깁니다.

## 담는 것 / 뺀 것

담는 것은 `files.txt` 가 전부입니다. 새 설정을 담으려면 한 줄 추가하고 `./export.sh` 합니다.

**공개 저장소입니다.** 아래는 일부러 뺐고, 새로 추가할 파일도 먼저 열어 토큰·계정·`/Users/…` 경로가 없는지 확인합니다.

| 뺀 것 | 이유 |
|---|---|
| `github.xml`, `gitlab.xml`, `googleLogin*`, `settingsSync*`, `ai.providers.xml`, `agent-permissions.xml`, `studiobot*` | 계정·토큰 |
| `jdk.table.xml`, `android.sdk.path.xml`, `recentProjects.xml`, `trusted-paths.xml`, `window.*`, `emulator.xml`, `ide.general.local.xml` | 기기마다 다른 경로·상태 |
| `*statistics*`, `updates.xml`, `*.db`, `workspace/`, `tasks/`, `event-log-metadata/` | 통계·캐시 |
| `yiiguxing.translation.xml` | 설정은 번역기 하나뿐이고 나머지는 번역 기록·창 위치 |
| `plugins/` | 바이너리 — ID 목록(`plugins.txt`)만 담습니다 |
| `colors/`, `colors.scheme.xml` | Editor Color Scheme — UI 테마(Gerry Storm)를 따라갑니다 |
