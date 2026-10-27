#!/usr/bin/env bash
# 지금 쓰는 Android Studio 설정 중 files.txt 에 적힌 것만 config/ 로 내보냅니다.
# 사용: ./export.sh [설정 폴더]   (생략하면 가장 최신 AndroidStudio* 폴더)
set -euo pipefail
cd "$(dirname "$0")"
source ./common.sh

src="${1:-$(latest_config_dir)}"
echo "내보내는 곳: $src"

# 지운 설정도 반영되도록 매번 새로 담습니다.
rm -rf config
mkdir -p config
while IFS= read -r path; do
  if [ ! -e "$src/$path" ]; then
    echo "  없음(건너뜀): $path"
    continue
  fi
  mkdir -p "config/$(dirname "$path")"
  cp -R "$src/$path" "config/$path"
done < <(manifest)

if [ -f "$src/studio.vmoptions" ]; then
  grep -v "$TOOLBOX_LINE" "$src/studio.vmoptions" > config/studio.vmoptions || true
fi
find config -name .DS_Store -delete

{
  echo "# export.sh 가 만듭니다. 새 기기에서는 Settings > Plugins > Marketplace 에서 ID 로 찾아 설치합니다."
  list_plugins "$src/plugins"
} > plugins.txt

echo "완료. git status·git diff 로 바뀐 것을 확인한 뒤 커밋하세요."
