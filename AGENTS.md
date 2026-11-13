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

## Convención de numeración

Carpetas `00` a `09` por área; dentro de cada una, notas `X.1`, `X.2`, ... y su MOC `X.0`.
