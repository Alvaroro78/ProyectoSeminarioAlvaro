---
documento: prd
proyecto: ProyectoSeminarioAlvaro
version: 0.1.0
fecha: 2026-11-08
estado: borrador
autores: [Álvaro José Roa Álvarez]
---

# PRD · ProyectoSeminarioAlvaro

## Problema

Las organizaciones que hacen eventos recurrentes (charlas mensuales, talleres trimestrales, cursos de educación continua) rearman en cada edición el formulario de inscripción, los mensajes, el cupo y la lista de tareas. Lo que ya pasó —cuánta gente faltó, qué tareas se atrasaron, qué preguntas nadie respondió— queda en hojas sueltas y no se usa para preparar la edición siguiente.

## Usuarios

- **Organizador** (desde el computador): quiere dejar lista la siguiente edición sin rehacerla y sin repetir los errores de la anterior.
- **Invitado** (desde el celular): quiere ver qué eventos hay, inscribirse y tener a mano su código de inscripción.

## Objetivos

- **O-01** El organizador prepara una edición nueva a partir de la anterior sin volver a escribir su formulario, sus mensajes ni sus tareas. *Se cumple si* al crearla desde la anterior quedan heredados al menos el 80 % de sus campos, mensajes y tareas, y las fechas de tareas y mensajes se recalculan solas con la fecha nueva.
- **O-02** El organizador recibe recomendaciones sacadas de las ediciones pasadas. *Se cumple si* con 2 o más ediciones cerradas la edición en preparación muestra cada recomendación que aplica junto con el dato que la justifica, y cada una se puede aceptar o descartar.
- **O-03** El invitado se inscribe desde el celular. *Se cumple si* un invitado con sesión iniciada pasa de la lista de eventos a ver su código de inscripción en 3 pantallas o menos.
- **O-04** El organizador registra quién asistió. *Se cumple si* encuentra a un inscrito por nombre o por código, marca su asistencia con un toque y esa asistencia cuenta en las recomendaciones de las ediciones siguientes.

## Alcance

### Incluye

- Series de eventos y sus ediciones numeradas.
- Edición nueva a partir de la anterior, con fechas de tareas y mensajes relativas al día del evento.
- Formulario de inscripción con preguntas de texto, número y sí/no.
- Mensajes con variables (evento, fecha, hora, lugar, nombre) y su vista previa.
- Lista de tareas con responsable y fecha límite.
- Cinco recomendaciones: cupo, tareas que se atrasan, preguntas que casi nadie responde, invitados frecuentes y asistencia esperada.
- Porcentaje de trabajo reutilizado en cada edición.
- Inscripción con código, consulta de las inscripciones propias y registro de asistencia.
- Cuentas con rol de organizador o de invitado.

### No incluye

- Envío real de correos, SMS o WhatsApp: los mensajes quedan listos para copiar.
- Pagos, facturación y certificados.
- Lectura de códigos QR con la cámara.
- Recomendaciones con inteligencia artificial: todas salen de reglas fijas.
- Encuestas después del evento.
- Eventos virtuales o transmisión en vivo.
- Varios organizadores en una misma serie.
- Cancelar una inscripción.
- Editar un campo, mensaje o tarea ya creado: se quita y se agrega de nuevo.

## Restricciones

- Equipo de estudiantes de quinto semestre. El prototipo se presenta en la sesión 9 del curso y la app final en las sesiones 15 y 16.
- Funciona en el navegador del computador y en celulares Android.
- El prototipo trabaja con datos simulados; la versión final guarda los datos en la nube.
- Sin servidor propio y sin modelos de inteligencia artificial dentro de la app.

## Preguntas abiertas

- ¿Cuántas ediciones pasadas deben contar en las recomendaciones? Por ahora, las 3 últimas cerradas.
- ¿El organizador debería poder cambiar los umbrales de las reglas (20 % de respuestas, 2 ediciones, 90 % de asistencia)?
- ¿Un invitado puede cancelar su inscripción?
- ¿Se puede elegir como base una edición distinta a la más reciente?

## Historial

- 0.1.0 · 2026-11-08 · Primera versión.
