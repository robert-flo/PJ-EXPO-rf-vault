#!/usr/bin/env bash
# doctor: verifica el toolchain del programa y lo que falta, lo instala.
# Ruta: pacman para lo del sistema (Omarchy/Arch), mise para Bun.
# Con DOCTOR_DRY=1 solo reporta, no instala.
set -uo pipefail

DRY="${DOCTOR_DRY:-}"
missing_pacman=()
notes=()

have() { command -v "$1" >/dev/null 2>&1; }

install_pacman() {
  if [ -n "$DRY" ]; then
    echo "  [dry] sudo pacman -S --needed $*"
  else
    sudo pacman -S --needed "$@"
  fi
}

# Base del sistema
for t in git gh unzip; do
  have "$t" || missing_pacman+=("$t")
done

# Navegador para las pruebas (cualquiera sirve; exact apunta con CHROME= si hay varios)
BROWSER=""
for b in google-chrome-stable google-chrome chromium chromium-browser brave; do
  if have "$b"; then BROWSER="$b"; break; fi
done
if [ -z "$BROWSER" ]; then
  missing_pacman+=("chromium")
fi

# rustup: la toolchain exacta (1.97.0) la baja exact solo vía rust-toolchain.toml
if ! have rustup; then
  missing_pacman+=("rustup")
  notes+=("rustup recién instalado: corre 'rustup default stable' una vez")
fi

if [ ${#missing_pacman[@]} -gt 0 ]; then
  echo "Falta (pacman): ${missing_pacman[*]}"
  install_pacman "${missing_pacman[@]}"
else
  echo "Sistema al día: git, gh, unzip y navegador presentes."
fi

# bun: por mise (bun no está en los repos de Arch). mise está en pacman;
# si pacman no lo tiene, cae al instalador oficial de mise.run
if ! have bun; then
  if ! have mise; then
    if [ -n "$DRY" ]; then
      echo "  [dry] mise: sudo pacman -S --needed mise (o curl -fsSL https://mise.run | sh)"
    elif sudo pacman -S --needed --noconfirm mise >/dev/null 2>&1; then
      echo "mise instalado (pacman)"
    else
      echo "mise no está en pacman; instalando con mise.run..."
      curl -fsSL https://mise.run | sh
      export PATH="$HOME/.local/bin:$PATH"
    fi
    notes+=("mise recién instalado: corre 'mise use -g bun@1.4.2'")
  else
    notes+=("falta bun: corre 'mise use -g bun@1.4.2'")
  fi
fi

if [ ${#notes[@]} -gt 0 ]; then
  echo "Pasos manuales una sola vez:"
  for n in "${notes[@]}"; do echo "  - $n"; done
fi

# Reporte final
echo
echo "Estado:"
have git    && echo "  git:       $(git --version | awk '{print $3}')"    || echo "  git:       FALTA"
have gh     && echo "  gh:        $(gh --version | head -1 | awk '{print $3}')" || echo "  gh:        FALTA"
have bun    && echo "  bun:       $(bun --version)"                        || echo "  bun:       FALTA (mise use -g bun@1.4.2)"
have rustup && echo "  rustup:    $(rustup --version 2>/dev/null | head -1)" || echo "  rustup:    FALTA"
if [ -n "$BROWSER" ]; then echo "  navegador: $BROWSER"; else echo "  navegador: FALTA (chromium)"; fi

# Todo presente → siguiente paso
if have git && have gh && have bun && have rustup && [ -n "$BROWSER" ]; then
  echo
  echo "Toolchain listo. Siguiente paso: cd ~/dev/exact && bun scripts/exact.mjs setup"
fi
