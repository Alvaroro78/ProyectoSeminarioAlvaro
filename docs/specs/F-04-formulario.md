---
id: F-04
titulo: Formulario de inscripción
version: 0.1.0
fecha: 2026-11-08
estado: borrador
autores: [Álvaro José Roa Álvarez]
requisitos: [RF-06]
depende_de: [F-03]
---

# F-04 · Formulario de inscripción

## Objetivo

El organizador define qué preguntas responde el invitado al inscribirse. El nombre y el correo no se preguntan: salen de la cuenta del invitado.

## Flujo principal

1. El organizador abre el formulario de una edición y ve sus preguntas en orden. Cada una muestra su etiqueta, su tipo (texto, número o sí/no), si es obligatoria y si es heredada.
2. Agrega una pregunta: escribe la etiqueta, elige el tipo y si es obligatoria.
3. El sistema la agrega al final, sin marca de heredada, y recalcula el porcentaje reutilizado.
4. Quita una pregunta que nadie ha respondido en esa edición.

## Flujos alternos

- **A1 · Pregunta con respuestas:** si la pregunta ya tiene respuestas en esa edición, el sistema muestra "Esta pregunta ya tiene respuestas y no se puede quitar" y la conserva.
- **A2 · Edición cerrada:** el formulario se ve, pero no se puede agregar ni quitar nada.

## Reglas

- La etiqueta no está vacía y no se repite dentro de la edición.
- Una pregunta nueva no es heredada.
- Las preguntas de sí/no se responden eligiendo "Sí" o "No".

## Estados

- **Cargando:** no aplica.
- **Vacío:** "Este formulario no tiene preguntas: el invitado solo confirma su inscripción."
- **Error:** "Escribe la pregunta" o "Esa pregunta ya existe", debajo del campo.

## Datos

- Pregunta: etiqueta, tipo, obligatoria, orden, heredada.

## Criterios de aceptación

- **CA-1** Dado la edición 5 recién creada, con 100 % reutilizado, cuando el organizador agrega "Talla de camiseta" de tipo texto y opcional, entonces aparece al final sin marca de heredada y el porcentaje reutilizado baja a 94 %.
- **CA-2** Dado la pregunta "Cargo" de la edición 4, que ya tiene 1 respuesta, cuando el organizador intenta quitarla, entonces ve "Esta pregunta ya tiene respuestas y no se puede quitar".
- **CA-3** Dado una etiqueta vacía, cuando el organizador agrega, entonces ve "Escribe la pregunta" y no se agrega nada.
- **CA-4** Dado una edición cerrada, cuando el organizador abre su formulario, entonces no puede agregar ni quitar preguntas.

## Fuera de alcance

- Reordenar o editar preguntas.
- Preguntas de opción múltiple.

## Preguntas abiertas

- ¿Hace falta un límite de preguntas por formulario?

## Historial

- 0.1.0 · 2026-11-08 · Primera versión.
