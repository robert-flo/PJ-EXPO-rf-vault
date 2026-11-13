#!/usr/bin/env bash
# Validación básica de refs LLP: formato @ref LLP NNNN[#anchor]
# (checker completo: ./ref-check del repo ccheever/llp)
set -e
cd "$(dirname "$0")/.."
pat='@ref LLP [0-9]{4}(#[a-z0-9-]+)?'
refs=$(grep -rEoh "$pat" --include='*.md' --include='*.ts' --include='*.rs' --include='*.contract' . 2>/dev/null | sort -u || true)
if [ -z "$refs" ]; then echo "OK: sin refs LLP que validar (o ninguna escrita todavía)."; exit 0; fi
echo "$refs" | while read -r ref; do
  num=$(echo "$ref" | sed -E 's/@ref LLP ([0-9]{4}).*/\1/')
  doc=$(grep -rl "^# LLP $num" llp/ 2>/dev/null | head -1 || true)
  if [ -z "$doc" ]; then echo "FALTA: $ref -> no hay documento LLP $num en llp/"; else echo "OK: $ref -> $doc"; fi
done
