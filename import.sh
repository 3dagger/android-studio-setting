#!/usr/bin/env bash
# config/ 의 설정을 Android Studio 설정 폴더에 맞춥니다. files.txt 범위에서 저장소에 없는 파일은 지웁니다.
# 덮이거나 지워지는 파일은 backup/ 에 먼저 둡니다.
# 사용: ./import.sh [--dry-run] [설정 폴더]   (생략하면 가장 최신 AndroidStudio* 폴더)
#   --dry-run: 아무것도 바꾸지 않고 바뀔 파일과 차이만 보여 줍니다. Android Studio 가 켜져 있어도 됩니다.
# 넣을 때는 Android Studio 를 끈 상태여야 합니다 — 켜져 있으면 종료할 때 메모리의 설정으로 다시 덮어씁니다.
set -euo pipefail
cd "$(dirname "$0")"
source ./common.sh

dry_run=false
if [ "${1:-}" = --dry-run ]; then
  dry_run=true
  shift
fi
dst="${1:-$(latest_config_dir)}"
if ! $dry_run; then
  case "$dst" in
    "$(config_base)"/*)
      if studio_running; then
        echo "Android Studio 를 먼저 종료하세요." >&2
        exit 1
      fi
      ;;
  esac
fi
echo "IDE 설정 폴더: $dst"

# 비교할 IDE 쪽 내용입니다. vmoptions 는 그 기기의 Toolbox 줄을 빼고 봅니다.
current() {
  if [ "$1" = studio.vmoptions ]; then
    grep -v "$TOOLBOX_LINE" "$dst/$1" || true
  else
    cat "$dst/$1"
  fi
}

# 한 줄에 하나씩 "+ 경로"(새로 넣음), "~ 경로"(바뀜), "- 경로"(지움)입니다.
changes() {
  (cd config && find . -type f ! -name .DS_Store | sed 's|^\./||' | LC_ALL=C sort) | while IFS= read -r f; do
    if [ ! -e "$dst/$f" ]; then
      echo "+ $f"
    elif ! cmp -s <(current "$f") "config/$f"; then
      echo "~ $f"
    fi
  done
  manifest | while IFS= read -r path; do
    [ -e "$dst/$path" ] || continue
    (cd "$dst" && find "$path" -type f ! -name .DS_Store)
  done | LC_ALL=C sort | while IFS= read -r f; do
    [ -e "config/$f" ] || echo "- $f"
  done
}

list=$(changes)
if [ -z "$list" ]; then
  echo "차이 없음"
  $dry_run || mark_synced
  exit 0
fi
echo "$list"

if $dry_run; then
  echo "$list" | while read -r op f; do
    [ "$op" = "~" ] || continue
    diff -u -L "IDE: $f" -L "저장소: $f" <(current "$f") "config/$f" || true
  done
  exit 0
fi

backup="$PWD/backup/$(basename "$dst")-$(date +%Y%m%d-%H%M%S)"
echo "$list" | while read -r op f; do
  if [ -e "$dst/$f" ]; then
    mkdir -p "$backup/$(dirname "$f")"
    cp -p "$dst/$f" "$backup/$f"
  fi
  if [ "$op" = - ]; then
    rm "$dst/$f"
  else
    mkdir -p "$dst/$(dirname "$f")"
    # 그 기기의 Toolbox 줄은 남깁니다.
    { [ "$f" = studio.vmoptions ] && [ -f "$dst/$f" ] && grep "$TOOLBOX_LINE" "$dst/$f"; cat "config/$f"; } > "$dst/$f.tmp"
    mv "$dst/$f.tmp" "$dst/$f"
  fi
done
mark_synced

[ -d "$backup" ] && echo "덮이거나 지운 파일 백업: $backup"
echo "완료. 플러그인은 Settings > Plugins 에서 설치하세요:"
grep -v '^#' plugins.txt || true
