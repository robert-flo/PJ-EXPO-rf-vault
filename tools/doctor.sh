#!/usr/bin/env bash
# make doctor — verifica, informa y RESUELVE el toolchain del programa.
# Corre `make doctor` otra vez hasta que termine con TODO LISTO.
# Lo que no necesita sudo se arregla solo (rustup, bun, checkout y setup de
# exact); lo de pacman necesita tu contraseña, así que córrelo en tu terminal.
set -u
cd "$(dirname "$0")/.."
export PATH="$HOME/.cargo/bin:$HOME/.bun/bin:$PATH"
[ -f "$HOME/.cargo/env" ] && . "$HOME/.cargo/env"

RUSTV=1.97.0
exact_dir="${EXACT:-proyectos/exact}"

cmd(){ command -v "$1" >/dev/null 2>&1 ; }
chrom(){ cmd chromium || cmd chromium-browser || cmd google-chrome-stable || cmd brave ; }
rustup_ok(){ cmd rustup || [ -x "$HOME/.cargo/bin/rustup" ] ; }
bun_ok(){ cmd bun || [ -x "$HOME/.bun/bin/bun" ] ; }
chain_ok(){ rustup toolchain list 2>/dev/null | grep -q "$RUSTV" ; }
checkout_ok(){ [ -f "$exact_dir/scripts/app-cli.mjs" ] ; }

echo "== Diagnóstico =="
PKGS=()
for p in curl unzip git gh ; do cmd "$p" || PKGS+=("$p") ; done
if chrom ; then : ; else PKGS+=("chromium") ; fi
if ! ( cmd cc || cmd gcc || cmd clang ) ; then PKGS+=("base-devel") ; fi
if [ ${#PKGS[@]} -gt 0 ] ; then printf '  FALTA   pacman: %s\n' "${PKGS[*]}"
else printf '  OK      curl, unzip, git, gh, chromium\n' ; fi
if rustup_ok ; then printf '  OK      rustup\n' ; else printf '  FALTA   rustup\n' ; fi
if chain_ok ; then printf '  OK      rust %s\n' "$RUSTV" ; else printf '  FALTA   rust %s\n' "$RUSTV" ; fi
if bun_ok ; then printf '  OK      bun\n' ; else printf '  FALTA   bun\n' ; fi
if checkout_ok ; then printf '  OK      checkout exact (%s)\n' "$exact_dir"
else printf '  FALTA   checkout exact (%s)\n' "$exact_dir" ; fi
if gh auth status >/dev/null 2>&1 ; then printf '  OK      gh autenticado\n'
else printf '  FALTA   gh autenticado (se arregla con: gh auth login)\n' ; fi

echo "== Resolviendo lo que falta =="

if [ ${#PKGS[@]} -gt 0 ] ; then
  if sudo pacman -S --needed --noconfirm "${PKGS[@]}" ; then
    printf '  instalado con pacman: %s\n' "${PKGS[*]}"
  else
    printf '  no pude usar sudo: corre `make doctor` en tu terminal (pide tu contraseña)\n'
  fi
fi

if ! rustup_ok ; then
  # limpieza: un enlace simbólico roto de una instalación anterior bloquea al instalador
  for d in "$HOME/.cargo" "$HOME/.rustup" ; do
    [ -L "$d" ] && [ ! -e "$d" ] && rm "$d" && printf '  limpiado enlace roto: %s\n' "$d"
  done
  curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y --default-toolchain "$RUSTV" \
    && printf '  rustup instalado (nuevas terminales ya lo tienen en PATH)\n'
fi
if rustup_ok && ! chain_ok ; then
  rustup toolchain install "$RUSTV" --profile minimal && printf '  rust %s instalado\n' "$RUSTV"
fi

if ! bun_ok ; then
  curl -fsSL https://bun.sh/install | bash && printf '  bun instalado en ~/.bun\n'
fi

if ! checkout_ok ; then
  mkdir -p proyectos
  git clone --depth 1 https://github.com/expo/exact "$exact_dir" \
    && printf '  clonado: %s\n' "$exact_dir"
fi
if checkout_ok ; then
  git -C "$exact_dir" pull --ff-only 2>/dev/null || true
  if bun_ok ; then BUN="$(command -v bun || echo "$HOME/.bun/bin/bun")" ; fi
  printf '  setup de exact (la primera vez tarda varios minutos)...\n'
  if (cd "$exact_dir" && "$BUN" scripts/exact.mjs setup) ; then
    printf '  setup de exact: listo\n'
  else
    printf '  setup de exact: quedó a medias; vuelve a correr `make doctor` para reintentarlo\n'
  fi
fi

echo "== Verificación final =="
fin=0
for p in curl unzip git gh ; do cmd "$p" || { printf '  FALTA   %s\n' "$p" ; fin=$((fin+1)) ; } ; done
if chrom ; then : ; else printf '  FALTA   chromium\n' ; fin=$((fin+1)) ; fi
( cmd cc || cmd gcc || cmd clang ) || { printf '  FALTA   compilador C (cc/gcc)
' ; fin=$((fin+1)) ; }
rustup_ok || { printf '  FALTA   rustup\n' ; fin=$((fin+1)) ; }
chain_ok || { printf '  FALTA   rust %s\n' "$RUSTV" ; fin=$((fin+1)) ; }
bun_ok || { printf '  FALTA   bun\n' ; fin=$((fin+1)) ; }
checkout_ok || { printf '  FALTA   checkout exact (%s)\n' "$exact_dir" ; fin=$((fin+1)) ; }

if [ "$fin" -eq 0 ] ; then
  echo "TODO LISTO: toolchain completo."
  exit 0
else
  echo "Quedan $fin pendientes. Vuelve a correr: make doctor"
  exit 1
fi
