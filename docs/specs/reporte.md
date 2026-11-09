# Reporte de specs · ProyectoSeminarioAlvaro

Fecha: 2026-11-08 · Revisado: prd 0.1.0 · requisitos 0.1.0 · spine 0.1.0 · modelo s/v · 13 specs · F-01–F-06 y F-09–F-13 v0.1.0 · F-07 y F-08 v0.2.0

## Métricas

| Métrica | Resultado | Semáforo |
|---|---|---|
| **Completitud** | 23/23 · 100 % | 🟢 Verde |
| **Trazabilidad RF→objetivo** | 23/23 · 100 % | 🟢 Verde |
| **Trazabilidad spec→RF** | 13/13 · 100 % | 🟢 Verde |
| **Verificabilidad** | 57/57 · 100 % | 🟢 Verde |
| **Ambigüedad** | 0 palabras vagas | 🟢 Verde |
| **Consistencia** | 0 contradicciones | 🟢 Verde |
| **Atomicidad** | 0 specs con dos flujos independientes | 🟢 Verde |
| **Pureza funcional** | 0 menciones de tecnología | 🟢 Verde |
| **Preguntas abiertas** | 12 (1 por spec salvo F-12) | — |
| **Avance de implementación** | Todo en borrador · 0/13 aprobadas · 0/13 implementadas | — |
| **Estabilidad** | F-07 y F-08 en v0.2.0; el resto en v0.1.0; sin cambios mayores | 🟢 Verde |

---

## Correcciones aplicadas en esta versión

### 1 · F-07 v0.2.0 · CA-3 — precondición completada

**Archivo:** `docs/specs/F-07-ciclo-edicion.md` · apartado **Criterios de aceptación**

Se añadió "(capacidad 20)" a la precondición del CA-3. El lector ya puede verificar el cálculo `cupo_sugerido = floor(20 ÷ 0,59) = 34` sin asumir datos implícitos.

### 2 · F-08 v0.2.0 · CA-2 y CA-3 — criterios autocontenidos

**Archivo:** `docs/specs/F-08-recomendaciones.md` · apartado **Criterios de aceptación**

Se incluyeron los retrasos históricos de cada tarea tomados de `docs/datos_simulados.md`:

- "Publicar la invitación" (D-10): retrasos +3, +2, +4 en ediciones 1, 2 y 3; promedio 3 → D-13.
- "Enviar el agradecimiento" (D+2): retrasos 0, +2, +1; promedio sobre las 3 ediciones = 1 → D+1.
- "Reservar el auditorio" (D-21): retrasos +4, +3, +5; promedio 4 → D-25.

### 3 · F-08 v0.2.0 · R3 — caso borde de denominador cero

**Archivo:** `docs/specs/F-08-recomendaciones.md` · apartado **Reglas** · regla R3

Se añadió: "Si los inscritos de esas ediciones suman 0, la tasa se considera indefinida y esa pregunta no genera recomendación." También se aclaró que "inscritos" son todos los de las ediciones de H que tenían la pregunta, sin importar si respondieron el formulario.

---

## Problemas menores pendientes (no bloquean, corregir en próxima versión)

- **F-09 · depende_de** incluye `F-05` solo por el flujo A1 (mostrar el texto del mensaje de invitación). Es una dependencia de presentación, no de flujo principal. Considerar si basta con mencionarlo en el flujo sin declararlo en el frontmatter.
- **F-03 · RF-02 duplicado en README**: RF-02 aparece en F-02 y F-03. RF-02 describe crear la primera edición, que F-03 cubre en el flujo A1. F-02 no describe ese flujo; solo enlaza a F-03. El frontmatter de F-02 debería omitir RF-02 o la spec debería aclarar que F-02 delega RF-02 a F-03.
- **F-07 · flujo alterno faltante**: las Reglas dicen "Solo se cierra una edición publicada" pero no hay un flujo alterno ni CA que describa qué ve el organizador si intenta cerrar una edición en borrador.
- **F-08 · R1 condición doble**: R1 dice "Aparece si el cupo actual es menor que el sugerido", pero si `cupo actual ≥ sugerido` y la tasa es de todas formas menor que 0,9, no hay recomendación aunque asista menos del 90 %. Aclarar si la condición de tasa < 0,9 es suficiente para disparar o si también requiere `cupo < sugerido`.

---

## Lo que está bien

- **Completitud y trazabilidad perfectas:** los 23 RF están cubiertos por al menos una spec, cada RF cita su objetivo y cada spec cita sus RF.
- **Verificabilidad plena:** todos los 57 criterios de aceptación tienen forma Dado/cuando/entonces con resultado observable. Tras aplicar las correcciones, los CA de R2 son autocontenidos.
- **Pureza funcional:** ninguna spec menciona Flutter, Supabase, SQL ni ningún otro detalle de implementación.
- **Ambigüedad cero:** no hay palabras vagas ("rápido", "fácil", "intuitivo", etc.) en ninguna de las 13 specs.
- **Criterios concretos con datos simulados:** la mayoría de CA usa nombres, fechas y números exactos sacados de los datos simulados, lo que hace que las pruebas sean reproducibles.
- **Consistencia general:** las reglas de F-07 (edición cerrada = solo lectura) se respetan coherentemente en F-04, F-05, F-06, F-08 y F-13 sin contradicciones.
- **Reglas aritméticas verificables:** R1, R2 y R5 de F-08 dan fórmulas exactas y CA con números que se pueden comprobar manualmente.
- **Estados y flujos alternos cubiertos:** todas las specs tienen sección de Estados con los tres casos (cargando, vacío, error) y flujos alternos para las variantes principales.
