# android-studio-setting

어느 기기에서나 같은 Android Studio 개인 설정(키맵·Live Template·색 테마·글꼴·편집기)을 쓰기 위한 저장소입니다.
설정 폴더를 통째로 올리지 않고 `files.txt` 에 적은 것만 담습니다. macOS·Linux 에서 동작합니다.

프로젝트 설정(코드 스타일·Run Configuration 등)은 여기가 아니라 각 프로젝트 저장소가 맡습니다.

## 새 기기에서

1. Android Studio 를 설치하고 한 번 실행했다가 **종료**합니다(설정 폴더가 생깁니다).
2. 받아서 넣습니다.
   ```bash
   git clone https://github.com/3dagger/android-studio-setting.git ~/android-studio-setting
   ~/android-studio-setting/import.sh
   ```
3. 끝에 나오는 플러그인(`plugins.txt`)을 Settings > Plugins > Marketplace 에서 설치합니다.

덮인 파일은 `backup/<설정 폴더>-<시각>/` 에 남습니다(커밋하지 않습니다).

## 설정을 바꾼 뒤

```bash
cd ~/android-studio-setting
./export.sh
git diff
git commit -am "..." && git push
```

Android Studio 는 설정을 바로 저장하지 않을 수 있으니, 바꾼 직후라면 창을 한 번 벗어나거나 종료한 뒤 내보냅니다.

## 동작

- 설정 폴더는 버전마다 따로 생깁니다(`~/Library/Application Support/Google/AndroidStudio2026.2.1`, Linux 는 `~/.config/Google/…`). 두 스크립트 모두 가장 높은 버전 폴더를 고르고, 다른 폴더는 인자로 줍니다: `./import.sh <설정 폴더>`.
- `export.sh` 는 `config/` 를 매번 새로 채웁니다. 지운 설정도 diff 에 나옵니다.
- `import.sh` 는 `config/` 의 파일을 덮어쓰기만 하고, 설정 폴더의 다른 파일은 건드리지 않습니다. Android Studio 가 켜져 있으면 멈춥니다(종료할 때 메모리의 설정으로 다시 덮어쓰기 때문입니다).
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
| `colors/` 의 나머지 | 쓰지 않는 사본과 Material Theme 플러그인이 만든 테마 |
