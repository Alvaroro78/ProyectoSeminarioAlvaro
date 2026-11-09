---
id: F-10
titulo: Eventos publicados
version: 0.1.0
fecha: 2026-11-08
estado: borrador
autores: [Álvaro José Roa Álvarez]
requisitos: [RF-19]
depende_de: [F-01, F-07]
---

# F-10 · Eventos publicados

## Objetivo

El invitado ve desde su celular qué eventos tienen inscripciones abiertas y si todavía hay cupo.

## Flujo principal

1. El invitado ve los eventos publicados con fecha posterior a hoy, ordenados por fecha. Cada uno muestra el nombre del evento, la fecha, la hora, el lugar y su estado de cupo: "Quedan N cupos", "Sin cupos" o "Ya estás inscrito".
2. Abre un evento y ve la descripción de la serie, el detalle y la opción de inscribirse (F-11).

## Flujos alternos

- **A1 · Sin cupos:** la opción de inscribirse aparece inactiva con el texto "Sin cupos".
- **A2 · Ya inscrito:** en lugar de inscribirse aparece "Ya estás inscrito · código".

## Reglas

- Cupos libres = cupo − inscritos.
- Las ediciones en borrador, las cerradas y las de fecha pasada no aparecen.

## Estados

- **Cargando:** "Cargando eventos…".
- **Vacío:** "No hay eventos abiertos por ahora."
- **Error:** "No se pudieron cargar los eventos. Intenta de nuevo."

## Datos

- Evento: nombre de la serie y número de edición, descripción, fecha, hora, lugar, cupo, inscritos.

## Criterios de aceptación

Con los datos simulados y hoy = 8 nov 2026:

- **CA-1** Dado la invitada Valentina Ríos, cuando entra, entonces ve 2 eventos en este orden: "Ciclo de charlas de analítica de datos · Edición 4" con "Quedan 12 cupos" y "Club de lectura de ingeniería · Edición 1" con "Sin cupos".
- **CA-2** Dado el "Club de lectura de ingeniería · Edición 1", con 12 inscritos de 12, cuando Valentina lo abre, entonces la opción de inscribirse está inactiva y dice "Sin cupos".
- **CA-3** Dado una edición en borrador, cuando el invitado ve la lista, entonces esa edición no aparece.

## Fuera de alcance

- Buscar o filtrar eventos.
- Lista de espera.

## Preguntas abiertas

- ¿Hace falta una lista de espera cuando no hay cupos?

## Historial

- 0.1.0 · 2026-11-08 · Primera versión.
