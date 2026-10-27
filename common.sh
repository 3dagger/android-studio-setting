# export.sh·import.sh 가 함께 씁니다.

# Toolbox 가 studio.vmoptions 에 넣는 기기별 줄(-Dide.managed.by.toolbox=…, -Dtoolbox.notification.…)입니다.
TOOLBOX_LINE='toolbox'

config_base() {
  case "$(uname -s)" in
    Darwin) echo "$HOME/Library/Application Support/Google" ;;
    Linux) echo "${XDG_CONFIG_HOME:-$HOME/.config}/Google" ;;
    *) echo "지원하지 않는 OS 입니다: $(uname -s)" >&2; return 1 ;;
  esac
}

# 버전마다 폴더가 따로 생기므로(AndroidStudio2026.2.1 …) 가장 높은 버전을 고릅니다.
latest_config_dir() {
  local dir
  dir=$(ls -d "$(config_base)"/AndroidStudio[0-9]* 2>/dev/null | sort -V | tail -1)
  if [ -z "$dir" ]; then
    echo "Android Studio 설정 폴더가 없습니다. Android Studio 를 한 번 실행했다가 종료하세요." >&2
    return 1
  fi
  echo "$dir"
}

studio_running() {
  pgrep -f 'Contents/MacOS/studio|/bin/studio' > /dev/null
}

manifest() {
  grep -v -e '^#' -e '^[[:space:]]*$' files.txt
}

# plugins/ 의 jar 에서 마켓플레이스 ID 와 이름을 뽑습니다.
list_plugins() {
  local p jar xml
  for p in "$1"/*/; do
    for jar in "$p"lib/*.jar; do
      xml=$(unzip -p "$jar" META-INF/plugin.xml 2> /dev/null) || continue
      [ -n "$xml" ] || continue
      printf '%s  # %s\n' \
        "$(sed -n 's:.*<id>\(.*\)</id>.*:\1:p' <<< "$xml" | head -1)" \
        "$(sed -n 's:.*<name>\(.*\)</name>.*:\1:p' <<< "$xml" | head -1)"
      break
    done
  done
}
