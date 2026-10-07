#!/bin/sh
# Usage: play-sound.sh <name>
# Plays sounds/<preset>/<name>.mp3 without blocking; silent no-op if no player is found.
# The preset comes from the plugin option (CLAUDE_PLUGIN_OPTION_PRESET) and falls back to "default".
dir=$(cd "$(dirname "$0")" && pwd)
preset="${CLAUDE_PLUGIN_OPTION_PRESET:-default}"
case "$preset" in
  *[!A-Za-z0-9_-]*) preset=default ;;
esac
file="$dir/../sounds/$preset/$1.mp3"
[ -f "$file" ] || file="$dir/../sounds/default/$1.mp3"
[ -f "$file" ] || exit 0

play() {
  nohup "$@" >/dev/null 2>&1 &
}

case "$(uname -s)" in
  Darwin)
    play afplay "$file"
    ;;
  MINGW* | MSYS* | CYGWIN*)
    play powershell.exe -NoProfile -ExecutionPolicy Bypass \
      -File "$(cygpath -w "$dir/play-sound.ps1")" "$(cygpath -w "$file")"
    ;;
  *)
    if command -v mpg123 >/dev/null 2>&1; then
      play mpg123 -q "$file"
    elif command -v ffplay >/dev/null 2>&1; then
      play ffplay -nodisp -autoexit -loglevel quiet "$file"
    elif command -v mpv >/dev/null 2>&1; then
      play mpv --no-video --really-quiet "$file"
    elif command -v cvlc >/dev/null 2>&1; then
      play cvlc --play-and-exit --quiet "$file"
    elif command -v paplay >/dev/null 2>&1; then
      play paplay "$file"
    fi
    ;;
esac
exit 0
