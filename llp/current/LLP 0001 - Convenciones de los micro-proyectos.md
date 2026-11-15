# LLP 0001: Convenciones de los micro-proyectos

**Type:** Explainer
**Status:** Active
**Systems:** Core
**Role:** Standard
**Author:** robert-flo
**Date:** 2026-11-14

## Overview

Los micro-proyectos del programa viven en [robert-flo/exact-proyectos](https://github.com/robert-flo/exact-proyectos), una carpeta por proyecto. Son material de estudio, no producto: el usuario no escribe código, lee, entiende y explica. Este LLP fija las dos convenciones que hacen posible eso, y el formato sigue el estándar de [ccheever/llp](https://github.com/ccheever/llp): decisiones en markdown, versionadas, citadas desde el código con `@ref`.

## #codigo-comentado — Código comentado para enseñar

Todo archivo de código de un micro-proyecto lleva comentarios profusos, en español, escritos como quien se los explica a un alumno: qué hace cada bloque, por qué está ahí y qué pasa si se quita. Los comentarios SON la lección, dentro del código donde viven los conceptos que explican. El cierre de un proyecto no es que la app funcione: es que el usuario pueda explicarla con sus palabras.

Reglas para agentes que escriben o regeneran código de estos repos:

- Conservar y actualizar los comentarios; nunca "limpiar" archivos de ellos.
- Excepción real: `*.test.contract` no admite comentarios en su DSL; la explicación de esas pruebas va en el README del proyecto.
- Sin firma de agente ni plataforma en commits ni comentarios; escritos como los escribiría una persona.

Referencia desde el código: `@ref LLP 0001#codigo-comentado — Código como material de estudio`.

## #mapa-de-archivos — README con mapa de archivos

El `README.md` de cada proyecto incluye una tabla con CADA archivo del proyecto, excluyendo lo generado (`target/`, `.exact/`, `node_modules/`): su función y por qué existe, en una frase. Objetivo: que al abrir el repo sepas por qué está cada archivo. Un archivo nuevo entra con su fila de tabla en el mismo commit.

Referencia: `@ref LLP 0001#mapa-de-archivos`.

## Validación

Los `@ref` de los repos de proyectos apuntan a LLPs de este vault; se validan con `tools/llp-check.sh` aquí (`make llp-check`).

#llp-root
