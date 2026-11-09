---
id: F-07
titulo: Ciclo de vida de la edición
version: 0.2.0
fecha: 2026-11-08
estado: borrador
autores: [Álvaro José Roa Álvarez]
requisitos: [RF-11]
depende_de: [F-03]
---

# F-07 · Ciclo de vida de la edición

## Objetivo

El organizador controla cuándo una edición recibe inscripciones y cuándo pasa a ser historia que alimenta las recomendaciones.

## Flujo principal

1. Una edición nace en borrador: solo la ve el organizador.
2. El organizador la publica: los invitados la ven y se pueden inscribir.
3. Después del evento, el organizador la cierra: queda de solo lectura y entra al historial.

## Flujos alternos

- **A1 · Publicar con fecha pasada:** el sistema muestra "Para publicar, la fecha debe ser posterior a hoy" y la deja en borrador.

## Reglas

- Estados en orden: borrador → publicada → cerrada. No se vuelve atrás.
- Solo se publica una edición con fecha posterior a hoy.
- Solo se cierra una edición publicada.
- En una edición cerrada no se cambian preguntas, mensajes, tareas, asistencia ni recomendaciones.
- Solo las ediciones cerradas cuentan como historial en F-08 y F-09.

## Estados

- **Cargando:** no aplica.
- **Vacío:** no aplica.
- **Error:** el mensaje de A1.

## Datos

- Edición: estado, fecha.

## Criterios de aceptación

- **CA-1** Dado una edición en borrador con fecha futura, cuando el organizador la publica, entonces queda publicada y aparece en los eventos de los invitados.
- **CA-2** Dado una edición publicada, cuando el organizador la cierra, entonces desaparecen las opciones para cambiar preguntas, mensajes, tareas y asistencia.
- **CA-3** Dado la edición 4 de los datos simulados (capacidad 20) cerrada sin asistentes marcados, cuando el organizador crea y abre la edición 5, entonces la recomendación de cupo usa las ediciones 2, 3 y 4: "asistieron 27 de 46 inscritos (59 %)" y "abre 34 cupos".
- **CA-4** Dado una edición en borrador con fecha pasada, cuando el organizador intenta publicarla, entonces ve "Para publicar, la fecha debe ser posterior a hoy".

## Fuera de alcance

- Reabrir una edición cerrada.
- Cerrar sola una edición cuando pasa su fecha.

## Preguntas abiertas

- ¿Debería avisarse al organizador que tiene ediciones publicadas cuya fecha ya pasó?

## Historial

- 0.2.0 · 2026-11-08 · CA-3: se añade "capacidad 20" a la precondición para que el cálculo del cupo sugerido sea verificable sin datos implícitos.
- 0.1.0 · 2026-11-08 · Primera versión.
