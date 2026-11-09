---
id: F-05
titulo: Mensajes de la edición
version: 0.1.0
fecha: 2026-11-08
estado: borrador
autores: [Álvaro José Roa Álvarez]
requisitos: [RF-05, RF-07, RF-08]
depende_de: [F-03]
---

# F-05 · Mensajes de la edición

## Objetivo

El organizador tiene listos los textos de invitación, recordatorio y agradecimiento de cada edición, con su fecha de envío calculada, para copiarlos al canal que use.

## Flujo principal

1. El organizador abre los mensajes de una edición y los ve ordenados por fecha de envío. Cada uno muestra tipo, días y fecha ("D-12 · 3 nov"), asunto, vista previa del cuerpo y si ya se envió.
2. La vista previa muestra el texto con las variables reemplazadas.
3. El organizador copia el texto a su canal y marca el mensaje como enviado.
4. Agrega un mensaje: tipo, días respecto al evento, asunto y cuerpo.
5. Quita un mensaje.

## Flujos alternos

- **A1 · Mensaje vencido:** si la fecha de envío ya pasó y no se ha marcado enviado, se muestra "Pendiente desde el 3 nov".
- **A2 · Edición cerrada:** los mensajes se ven, pero no se puede agregar, quitar ni marcar nada.

## Reglas

- Variables:
  - `{evento}`: "nombre de la serie · Edición N".
  - `{fecha}`: la fecha del evento, como "15 nov 2026".
  - `{hora}`: la hora del evento, como "18:00".
  - `{lugar}`: el lugar del evento.
  - `{nombre}`: en la vista previa se reemplaza por "invitado".
- Una variable que no está en la lista se deja como está.
- El asunto y el cuerpo no están vacíos. Los días van de −60 a 30.
- El sistema no envía mensajes: el organizador los copia y marca cuáles envió.

## Estados

- **Cargando:** no aplica.
- **Vacío:** "Esta edición no tiene mensajes."
- **Error:** "Escribe el asunto y el cuerpo" o "Los días deben estar entre −60 y 30".

## Datos

- Mensaje: tipo, asunto, cuerpo, días respecto al evento, enviado, heredado.

## Criterios de aceptación

- **CA-1** Dado el mensaje de invitación de la edición 4 de los datos simulados, cuando el organizador lo ve, entonces la vista previa dice "Hola invitado: el 15 nov 2026 a las 18:00 tendremos Ciclo de charlas de analítica de datos · Edición 4 en Auditorio principal · Edificio A. Inscríbete desde la app; los cupos son limitados."
- **CA-2** Dado el recordatorio de la edición 4 sin enviar, cuando el organizador lo marca enviado, entonces el mensaje muestra "Enviado".
- **CA-3** Dado un asunto vacío, cuando el organizador agrega el mensaje, entonces ve "Escribe el asunto y el cuerpo" y no se agrega.
- **CA-4** Dado la edición 5 el 20 dic, cuando el organizador ve la invitación (D-12), entonces su fecha de envío es el 8 dic.

## Fuera de alcance

- Enviar mensajes por correo, SMS o WhatsApp.
- Personalizar `{nombre}` con cada inscrito.

## Preguntas abiertas

- ¿Hace falta un botón que copie el texto con un toque?

## Historial

- 0.1.0 · 2026-11-08 · Primera versión.
