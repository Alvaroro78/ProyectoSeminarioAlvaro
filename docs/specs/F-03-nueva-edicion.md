---
id: F-03
titulo: Nueva edición a partir de la anterior
version: 0.1.0
fecha: 2026-11-08
estado: borrador
autores: [Álvaro José Roa Álvarez]
requisitos: [RF-02, RF-03, RF-04, RF-05, RF-10]
depende_de: [F-02]
---

# F-03 · Nueva edición a partir de la anterior

## Objetivo

El organizador prepara la siguiente edición copiando la anterior, para no rehacer el formulario, los mensajes ni las tareas, y ve cuánto trabajo se reutilizó.

## Flujo principal

1. En una serie con ediciones, el organizador pide una edición nueva.
2. El sistema muestra la edición base (la de número mayor) y lo que va a copiar: cuántas preguntas, mensajes y tareas.
3. El sistema propone fecha, hora, lugar, capacidad y cupo. El organizador los cambia si quiere.
4. El organizador confirma.
5. El sistema crea la edición con el número siguiente, en borrador, con copias de las preguntas, los mensajes y las tareas marcadas como heredadas, las tareas pendientes y los mensajes sin enviar.
6. El sistema muestra la edición nueva con su porcentaje reutilizado y con la fecha de cada tarea y de cada mensaje calculada con la fecha nueva.

## Flujos alternos

- **A1 · Primera edición:** si la serie no tiene ediciones, el sistema pide fecha, hora, lugar, capacidad y cupo sin proponer nada, y crea la edición 1 sin preguntas, mensajes ni tareas, con 0 % reutilizado.
- **A2 · Fecha inválida:** si la fecha no existe o no es posterior a hoy, el sistema muestra "La fecha debe ser posterior a hoy" y no crea nada.
- **A3 · Números inválidos:** si la capacidad o el cupo no son números enteros mayores que 0, el sistema muestra "Capacidad y cupo deben ser números mayores que 0".

## Reglas

- Fecha propuesta: la fecha de la última edición más los días entre las dos últimas ediciones. Con una sola edición, la última fecha más 30 días. Si el resultado no es posterior a hoy, se propone hoy más 7 días.
- Se copian lugar, hora, capacidad, cupo, preguntas, mensajes y tareas. No se copian inscripciones ni decisiones sobre recomendaciones.
- Fecha de una tarea o de un mensaje = fecha del evento + sus días respecto al evento. Se muestra así: "D-14 · 1 nov" antes del evento, "Día del evento" el mismo día y "D+2 · 17 nov" después.
- Porcentaje reutilizado = elementos heredados ÷ (preguntas + mensajes + tareas) × 100, redondeado al entero más cercano. Con 0 elementos es 0 %.
- La edición nueva guarda de qué edición nació. Cambiarla no cambia la edición base.

## Estados

- **Cargando:** no aplica; la edición se crea al confirmar.
- **Vacío:** serie sin ediciones, flujo A1.
- **Error:** los mensajes de A2 y A3, debajo del campo con el problema.

## Datos

- Edición base, fecha, hora, lugar, capacidad, cupo, preguntas, mensajes, tareas, porcentaje reutilizado.

## Criterios de aceptación

Con los datos simulados y hoy = 8 nov 2026:

- **CA-1** Dado la edición 4 (15 nov) y la edición 3 (11 oct), que están a 35 días, cuando el organizador pide una edición nueva, entonces la fecha propuesta es el 20 dic 2026.
- **CA-2** Dado la edición 4, con 6 preguntas, 3 mensajes y 7 tareas, cuando se crea la edición 5, entonces la 5 tiene esos 16 elementos marcados como heredados, ninguna tarea hecha, ningún mensaje enviado y 100 % reutilizado.
- **CA-3** Dado la tarea "Reservar el auditorio" en D-21 y la edición 5 el 20 dic, cuando el organizador mira las tareas de la 5, entonces la fecha límite es el 29 nov.
- **CA-4** Dado una fecha anterior a hoy, cuando el organizador confirma, entonces ve "La fecha debe ser posterior a hoy" y no se crea la edición.
- **CA-5** Dado una serie sin ediciones, cuando el organizador crea la primera, entonces queda la edición 1 en borrador con 0 % reutilizado.
- **CA-6** Dado la edición 5 recién creada, cuando el organizador quita una pregunta de la 5, entonces la edición 4 conserva esa pregunta.
- **CA-7** Dado la serie "Taller trimestral de primeros auxilios", con una sola edición el 30 ago, cuando el organizador pide la edición 2, entonces la fecha propuesta es el 15 nov 2026 (30 días después ya pasó, así que se propone hoy más 7).

## Fuera de alcance

- Elegir como base una edición distinta de la más reciente.
- Copiar las inscripciones.

## Preguntas abiertas

- ¿Debería poder elegirse la edición base?

## Historial

- 0.1.0 · 2026-11-08 · Primera versión.
