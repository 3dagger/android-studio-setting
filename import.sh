#!/usr/bin/env bash
# config/ 의 설정을 Android Studio 설정 폴더에 덮어씁니다. 덮이는 파일은 backup/ 에 먼저 둡니다.
# 사용: ./import.sh [설정 폴더]   (생략하면 가장 최신 AndroidStudio* 폴더)
# Android Studio 를 끈 상태에서 실행합니다 — 켜져 있으면 종료할 때 메모리의 설정으로 다시 덮어씁니다.
set -euo pipefail
cd "$(dirname "$0")"
source ./common.sh

dst="${1:-$(latest_config_dir)}"
case "$dst" in
  "$(config_base)"/*)
    if studio_running; then
      echo "Android Studio 를 먼저 종료하세요." >&2
      exit 1
    fi
    ;;
esac
backup="$PWD/backup/$(basename "$dst")-$(date +%Y%m%d-%H%M%S)"
echo "넣는 곳: $dst"

cd config
find . -type f | while IFS= read -r f; do
  f=${f#./}
  if [ -e "$dst/$f" ]; then
    mkdir -p "$backup/$(dirname "$f")"
    cp -p "$dst/$f" "$backup/$f"
  fi
  mkdir -p "$dst/$(dirname "$f")"
  if [ "$f" = studio.vmoptions ] && [ -f "$dst/$f" ]; then
    # 그 기기의 Toolbox 줄은 남깁니다.
    { grep "$TOOLBOX_LINE" "$dst/$f" || true; cat "$f"; } > "$dst/$f.tmp"
    mv "$dst/$f.tmp" "$dst/$f"
  else
    cp "$f" "$dst/$f"
  fi
done

[ -d "$backup" ] && echo "덮인 파일 백업: $backup"
echo "완료. 플러그인은 Settings > Plugins 에서 설치하세요:"
grep -v '^#' ../plugins.txt || true
