---
id: F-12
titulo: Mis inscripciones
version: 0.1.0
fecha: 2026-11-08
estado: borrador
autores: [Álvaro José Roa Álvarez]
requisitos: [RF-21]
depende_de: [F-11]
---

# F-12 · Mis inscripciones

## Objetivo

El invitado ve sus inscripciones con el código a mano y sabe a qué eventos asistió.

## Flujo principal

1. El invitado abre "Mis inscripciones".
2. El sistema muestra primero las próximas y después las pasadas. Cada una muestra el nombre del evento, la fecha, el código y su estado: "Próximo", "Asististe" o "No asististe".

## Flujos alternos

- Ninguno.

## Reglas

- Solo se muestran las inscripciones del invitado con sesión iniciada.
- Una inscripción es pasada si la fecha del evento es anterior a hoy.
- Una inscripción pasada sin asistencia marcada se muestra como "No asististe".
- Las próximas van de la más cercana a la más lejana; las pasadas, de la más reciente a la más antigua.

## Estados

- **Cargando:** "Cargando tus inscripciones…".
- **Vacío:** "Todavía no te has inscrito a ningún evento."
- **Error:** "No se pudieron cargar tus inscripciones."

## Datos

- Inscripción: evento, fecha, código, asistencia.

## Criterios de aceptación

Con los datos simulados:

- **CA-1** Dado la invitada Valentina Ríos, cuando abre "Mis inscripciones", entonces ve 3 inscripciones pasadas de "Ciclo de charlas de analítica de datos" (ediciones 3, 2 y 1), todas con "Asististe".
- **CA-2** Dado que Valentina se inscribió en la edición 4, cuando abre "Mis inscripciones", entonces la edición 4 aparece primera con "Próximo" y el código R4-009.
- **CA-3** Dado una cuenta de invitado nueva, cuando abre "Mis inscripciones", entonces ve "Todavía no te has inscrito a ningún evento."

## Fuera de alcance

- Certificados de asistencia.

## Preguntas abiertas

- Ninguna.

## Historial

- 0.1.0 · 2026-11-08 · Primera versión.
