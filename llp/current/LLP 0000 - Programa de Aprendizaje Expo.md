# LLP 0000: Programa de Aprendizaje Expo

**Type:** Explainer
**Status:** Draft
**Systems:** Core
**Role:** Root
**Author:** robert-flo
**Date:** 2026-11-13

## Overview

Programa de aprendizaje a largo plazo del ecosistema Exact by Expo, documentado desde el día 1 en este vault. No se busca una super-app: se buscan micro-proyectos acumulativos que, sumados, cubran todo lo que el ecosistema permite. El usuario trabaja y aprende; el agente escribe el vault, propone los micro-proyectos y supervisa el aprendizaje. Método: aprender haciendo, web primero para iterar rápido, sin checkpoints ni evaluaciones; la constancia y la perseverancia deciden el éxito a largo plazo.

## Áreas

1. **Exact Core** ([expo/exact](https://github.com/expo/exact)): la base principal. DSL Contract, runtime, agentes nativos.
2. **LLP** ([ccheever/llp](https://github.com/ccheever/llp)): Linked Literate Programming, implementado desde el día 1 como método de documentación del propio programa.
3. **Expo Simulators**: infraestructura agéntica de simuladores en la nube ([expo.dev/services/simulators](https://expo.dev/services/simulators)).
4. **Expo Explore**: explorar tu app en un mapa.
5. **Expo Service App**.

## Alcance de máquina

- Web y host Linux nativo en el PC Omarchy del usuario; prioridad web.
- Sin desarrollo Mac. Android llega con el tiempo y entra por el ecosistema Expo (Simulators), no por el core de Exact.

## Cómo trabaja este programa

- Micro-proyectos propuestos como issues del repo; el usuario y el agente acuerdan qué toca cada día.
- Cada sesión activa deja nota en `09 - Diario de Aprendizaje` con los campos: Aprendí hoy, Reforcé, Dudas abiertas, Siguiente paso, Refs.
- Las decisiones duraderas del programa se documentan en LLPs numerados referenciados con `@ref LLP NNNN#anchor`.

## Architecture

Programa de aprendizaje documental: no hay código en este repo salvo el vault mismo. Los artefactos de código que nazcan del aprendizaje vivan en repos aparte (`PJ-XXX-rf-...`) y referencian decisiones de este vault vía `@ref`.

#llp-root
