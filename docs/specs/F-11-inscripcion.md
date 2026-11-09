---
id: F-11
titulo: Inscripción a una edición
version: 0.1.0
fecha: 2026-11-08
estado: borrador
autores: [Álvaro José Roa Álvarez]
requisitos: [RF-20]
depende_de: [F-04, F-10]
---

# F-11 · Inscripción a una edición

## Objetivo

El invitado se inscribe respondiendo el formulario de la edición y recibe un código para identificarse el día del evento.

## Flujo principal

1. En el detalle del evento, el invitado ve las preguntas del formulario. Las obligatorias llevan "*".
2. Responde y confirma.
3. El sistema valida, crea la inscripción con su código y lleva al invitado a sus inscripciones (F-12), donde la nueva aparece primera con su código.

## Flujos alternos

- **A1 · Falta una obligatoria:** "Responde las preguntas marcadas con *". Lo escrito se conserva.
- **A2 · Número inválido:** "La respuesta de «etiqueta» debe ser un número".
- **A3 · Se acabaron los cupos:** si al confirmar ya no hay cupos, "Se acabaron los cupos" y no se crea la inscripción.
- **A4 · Ya inscrito:** no se muestra el formulario; se muestra "Ya estás inscrito · código".

## Reglas

- Una persona se inscribe una sola vez en cada edición.
- Código = "R" + número de la edición + "-" + consecutivo de 3 dígitos dentro de la edición. Ejemplo: R4-009.
- La fecha de inscripción es hoy.
- El nombre y el correo se toman de la cuenta.
- Las preguntas opcionales pueden quedar vacías. Las de sí/no se responden eligiendo "Sí" o "No".

## Estados

- **Cargando:** el botón muestra "Inscribiendo…" y no se puede volver a tocar.
- **Vacío:** si el formulario no tiene preguntas, solo se muestra el botón "Confirmar inscripción".
- **Error:** A1, A2 y A3, debajo del formulario.

## Datos

- Inscripción: persona, edición, código, fecha de inscripción, respuestas.

## Criterios de aceptación

Con los datos simulados:

- **CA-1** Dado Valentina Ríos y la edición 4, con 8 inscritos, cuando responde "Celular" y confirma, entonces recibe el código R4-009, la ve primera en sus inscripciones y el evento pasa a "Ya estás inscrito".
- **CA-2** Dado "Celular" vacío, cuando Valentina confirma, entonces ve "Responde las preguntas marcadas con *" y no se crea la inscripción.
- **CA-3** Dado que Valentina ya está inscrita en la edición 4, cuando abre el evento, entonces ve "Ya estás inscrito · R4-009" en lugar del formulario.

## Fuera de alcance

- Cancelar o editar una inscripción.
- Inscribir a otra persona.

## Preguntas abiertas

- ¿El invitado debería poder corregir sus respuestas?

## Historial

- 0.1.0 · 2026-11-08 · Primera versión.
