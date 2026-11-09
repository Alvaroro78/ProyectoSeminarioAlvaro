---
id: F-09
titulo: Invitación a asistentes frecuentes
version: 0.1.0
fecha: 2026-11-08
estado: borrador
autores: [Álvaro José Roa Álvarez]
requisitos: [RF-15, RF-17]
depende_de: [F-05, F-08]
---

# F-09 · Invitación a asistentes frecuentes

## Objetivo

El organizador reactiva a quienes ya vienen seguido y todavía no se han inscrito en la edición actual.

## Flujo principal

1. Con un historial de 2 o más ediciones cerradas (el mismo de F-08), el sistema busca a las personas que asistieron a 2 o más ediciones del historial y no están inscritas en la edición actual.
2. El sistema muestra la tarjeta R4: "Invita a N asistentes frecuentes", con la evidencia "Asistieron a 2 o más de las últimas M ediciones y no se han inscrito" y la lista de nombres y correos.
3. Si el organizador acepta, el sistema muestra el mensaje de invitación de la edición con las variables reemplazadas (F-05) junto con la lista de correos, para copiarlos, y guarda la decisión.
4. Si descarta, la tarjeta desaparece y se guarda la decisión.

## Flujos alternos

- **A1 · Sin mensaje de invitación:** al aceptar, el sistema muestra "Esta edición no tiene mensaje de invitación. Agrégalo en Mensajes." y guarda la decisión.
- **A2 · Nadie que invitar:** no aparece la tarjeta.

## Reglas

- Frecuente = asistió a 2 o más ediciones del historial.
- No se cuenta a quien ya está inscrito en la edición actual.
- La lista se ordena por nombre.
- La decisión se guarda con la regla R4 y sin referencia.

## Estados

- **Cargando:** "Calculando recomendaciones…" (el mismo de F-08).
- **Vacío:** A2.
- **Error:** el mismo de F-08.

## Datos

- Personas: nombre y correo. Asistencia en el historial. Inscritos de la edición actual.

## Criterios de aceptación

Con los datos simulados:

- **CA-1** Dado la edición 4, con 8 inscritos, cuando el organizador la abre, entonces la tarjeta nombra a 6 personas, en este orden: Camila Herrera, Isabella Zapata, Julián Arango, Nicolás Restrepo, Santiago Morales y Valentina Ríos.
- **CA-2** Dado la edición 5, sin inscritos, cuando el organizador la abre, entonces la tarjeta nombra a 14 personas.
- **CA-3** Dado la tarjeta de la edición 4, cuando el organizador acepta, entonces ve el texto de invitación con las variables reemplazadas y los 6 correos.

## Fuera de alcance

- Enviar la invitación desde la app.

## Preguntas abiertas

- ¿También conviene invitar a quienes se inscribieron y no asistieron?

## Historial

- 0.1.0 · 2026-11-08 · Primera versión.
