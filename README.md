# PJ-EXPO-rf-vault

Vault Obsidian del programa de aprendizaje del ecosistema Exact by Expo.
Vault standalone: no depende de ningún otro proyecto.

## Qué se aprende aquí

1. **Exact Core** ([expo/exact](https://github.com/expo/exact)): runtime multiplataforma. Base principal.
2. **LLP** ([ccheever/llp](https://github.com/ccheever/llp)): Linked Literate Programming. Implementado desde el día 1.
3. **Expo Simulators**: simuladores en la nube para agentes (infra agéntica).
4. **Expo Explore**: explorar tu app en un mapa.
5. **Expo Service App**.

Alcance de máquina: web y host Linux nativo (prioridad web para iterar rápido). Sin desarrollo Mac; Android entra más adelante por el ecosistema Expo.

## Cómo se usa

- El usuario **no escribe** en el vault: es el framework ordenado sobre el que trabaja el agente (ver `AGENTS.md`).
- Los micro-proyectos se proponen como issues del repo y quedan documentados en `09 - Diario de Aprendizaje`.
- Las decisiones del programa viven en `llp/` como documentos LLP numerados, validados con `make llp-check`.

## Make

```
make dia              # crea la nota de hoy en 09 - Diario de Aprendizaje
make nota AREA=01 TITULO="Mi nota"   # nota nueva numerada en un área
make llp-check        # valida las referencias @ref
make abrir            # abre el vault en Obsidian
make sync MSG="texto" # commit y push
```
