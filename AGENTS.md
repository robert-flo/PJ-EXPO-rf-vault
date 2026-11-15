# AGENTS.md

Marco de trabajo para cualquier agente que opere este vault.

## Reglas del vault

1. El vault escribe el agente; el usuario no edita archivos manualmente. El vault existe como framework ordenado para trabajar, no como bloc de notas del usuario.
2. Todo el contenido en español, con términos técnicos en inglés cuando así se les usa (Contract, runner, LLP, @ref).
3. Los commits, issues y comentarios se escriben como los escribiría una persona. Sin firma, sin pie de agente ni de plataforma.
4. Antes de escribir, releer el estado del repo para no pisar trabajo ajeno.

## Método del programa

- **Aprender haciendo**: micro-proyectos acumulativos, de lo básico a lo complejo. Nada de super-apps; cada pequeño avance suma.
- **Sin checkpoints ni evaluaciones**. Días de mucho avance, días de poco o nada. La constancia decide el éxito a largo plazo.
- Cada sesión activa es un **issue** del repo: el agente propone, usuario y agente acuerdan qué toca ese día, y se documenta en `09 - Diario de Aprendizaje`.
- Un issue por sesión activa. Los días sin sesión no generan issues ni notas.

## LLP desde el día 1

- Estructura upstream de `ccheever/llp`: `llp/current/` (lo que está en juego) y `llp/foundation/` (el núcleo estable).
- `LLP 0000` es el documento raíz del programa. Cada decisión duradera de aprendizaje o diseño se numera (`LLP 0001`, ...).
- El código que nazca en repos aparte referencia al vault con `@ref LLP NNNN#anchor`.
- Validar con `make llp-check`.
- Verificar toolchain de la máquina: `make doctor` (instala lo que falta con pacman o mise).

## Convención de numeración

Carpetas `00` a `09` por área; dentro de cada una, notas `X.1`, `X.2`, ... y su MOC `X.0`.

## Sesiones desde el vault (patrón Home Repo)

Las sesiones de agente arrancan en este vault, no dentro de los repos de código. Un clon por repo en disco; worktree por feature cuando haya trabajo en paralelo. Los punteros operativos están en [[07 - Proyectos/07.0 - Proyectos (MOC)|07 - Proyectos]] y resumidos abajo.

## Otros repos

- **exact** (runtime core, área 1): ~/dev/exact. Clonar de https://github.com/expo/exact si falta. Leer `docs/start-here.md` antes de cambiar algo; pre-1.0, cambia a diario.
- **exact-templates** (apps para instanciar): ~/dev/exact-templates. Clonar de https://github.com/expo/exact-templates. No se edita: se instancia con `bun new.mjs <template> ~/app --name N --bundle-id com.example.n`.
- **llp** (método, área 2): ~/dev/llp. Clonar de https://github.com/ccheever/llp. Fuente de las skills que se copian a `08 - Skills`; también trae `ref-check`.

Rutas ajustables; lo fijo es que el puntero siempre nombra ruta, origen de clon y hint.
