---
id: F-06
titulo: Tareas de la edición
version: 0.1.0
fecha: 2026-11-08
estado: borrador
autores: [Álvaro José Roa Álvarez]
requisitos: [RF-05, RF-09]
depende_de: [F-03]
---

# F-06 · Tareas de la edición

## Objetivo

El organizador sigue la lista de tareas de cada edición, con fechas límite que se recalculan solas, y deja registro de cuándo se hizo cada una.

## Flujo principal

1. El organizador abre las tareas de una edición y las ve ordenadas por fecha límite. Cada una muestra título, responsable, días y fecha límite ("D-21 · 25 oct") y su estado: pendiente, hecha o atrasada.
2. Marca una tarea como hecha. El sistema guarda la fecha de hoy como fecha en que se hizo.
3. Desmarca una tarea hecha. El sistema borra esa fecha.
4. Agrega una tarea: título, responsable y días respecto al evento.
5. Quita una tarea.
6. Arriba de la lista ve el resumen: "2 de 7 hechas · 1 atrasada".

## Flujos alternos

- **A1 · Edición cerrada:** las tareas se ven, pero no se puede marcar, agregar ni quitar nada.

## Reglas

- Una tarea está atrasada si no está hecha y su fecha límite es anterior a hoy. Se muestra "Atrasada N días".
- Retraso de una tarea hecha = días entre la fecha límite y la fecha en que se marcó hecha. Si se marcó antes o el mismo día, el retraso es 0. Este dato lo usa F-08.
- El título no está vacío. Los días van de −90 a 30.
- Una tarea nueva no es heredada.

## Estados

- **Cargando:** no aplica.
- **Vacío:** "Esta edición no tiene tareas."
- **Error:** "Escribe la tarea" o "Los días deben estar entre −90 y 30".

## Datos

- Tarea: título, responsable, días respecto al evento, fecha en que se hizo, heredada.

## Criterios de aceptación

Con los datos simulados y hoy = 8 nov 2026:

- **CA-1** Dado la edición 4 (15 nov), cuando el organizador ve sus tareas, entonces "Publicar la invitación" (D-10 · 5 nov) aparece "Atrasada 3 días".
- **CA-2** Dado una tarea pendiente de la edición 4, cuando el organizador la marca hecha, entonces queda hecha con fecha 8 nov y el resumen pasa de "2 de 7 hechas" a "3 de 7 hechas".
- **CA-3** Dado un título vacío, cuando el organizador agrega la tarea, entonces ve "Escribe la tarea" y no se agrega.
- **CA-4** Dado una edición cerrada, cuando el organizador abre sus tareas, entonces no puede marcarlas ni cambiarlas.

## Fuera de alcance

- Asignar tareas a cuentas de usuario: el responsable es un texto.
- Avisos cuando una tarea se atrasa.

## Preguntas abiertas

- ¿El responsable debería ser una persona con cuenta?

## Historial

- 0.1.0 · 2026-11-08 · Primera versión.
