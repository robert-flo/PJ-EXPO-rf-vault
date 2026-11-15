#!/usr/bin/env bash
# clone: trae al vault los repos de pruebas listados en tools/repos.list.
# Se clonan en proyectos/ (ignorada por git y por Obsidian).
set -uo pipefail
cd "$(dirname "$0")/.."
dest="proyectos"
mkdir -p "$dest"
ok=0; ya=0; fallo=0
while IFS= read -r line; do
  line="${line%%#*}"
  [ -z "$line" ] && continue
  name="${line##*/}"
  if [ -d "$dest/$name/.git" ]; then
    echo "ya está: $dest/$name"
    ya=$((ya+1))
    continue
  fi
  url="$line"
  [[ "$url" == http* ]] || url="https://github.com/$line.git"
  if git clone -q "$url" "$dest/$name"; then
    echo "clonado: $dest/$name"
    ok=$((ok+1))
  else
    echo "fallo al clonar: $url" >&2
    fallo=1
  fi
done < tools/repos.list
echo "listo: $ok clonados, $ya ya estaban"
exit $fallo
