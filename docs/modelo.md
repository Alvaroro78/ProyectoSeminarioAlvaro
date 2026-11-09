# Modelo de datos

## usuarios

- id (PK)
- nombre
- correo
- rol

## series

- id (PK)
- organizador_id (FK a usuarios)
- nombre
- descripcion
- creada_en

## ediciones

- id (PK)
- serie_id (FK a series)
- edicion_origen_id (FK a ediciones)
- numero
- fecha_hora
- lugar
- capacidad
- cupo
- estado

## campos

- id (PK)
- edicion_id (FK a ediciones)
- etiqueta
- tipo
- obligatorio
- orden
- heredado

## mensajes

- id (PK)
- edicion_id (FK a ediciones)
- tipo
- asunto
- cuerpo
- dias_offset
- enviado
- heredado

## tareas

- id (PK)
- edicion_id (FK a ediciones)
- titulo
- responsable
- dias_offset
- completada_en
- heredada

## inscripciones

- id (PK)
- edicion_id (FK a ediciones)
- usuario_id (FK a usuarios)
- codigo
- inscrita_en
- asistio

## respuestas

- id (PK)
- inscripcion_id (FK a inscripciones)
- campo_id (FK a campos)
- valor

## decisiones

- id (PK)
- edicion_id (FK a ediciones)
- regla
- referencia
- aceptada
- decidida_en

## Valores y notas

- `usuarios.id` es el mismo identificador de la cuenta con la que la persona inicia sesión.
- `usuarios.rol`: `organizador` o `invitado`.
- `ediciones.edicion_origen_id`: la edición de la que se copió; vacía si se creó desde cero.
- `ediciones.estado`: `borrador`, `publicada` o `cerrada`.
- `campos.tipo`: `texto`, `numero` o `si_no`. El nombre y el correo del invitado no son campos: salen de `usuarios`.
- `mensajes.tipo`: `invitacion`, `recordatorio`, `agradecimiento` u `otro`.
- `dias_offset`: días respecto al día del evento. Negativo es antes (−14), 0 es el mismo día y positivo es después (+2).
- `heredado` / `heredada`: verdadero si el elemento se copió de la edición de origen.
- `tareas.completada_en`: fecha en que se marcó hecha; vacía si está pendiente.
- `decisiones.regla`: `R1` a `R5`. `referencia` es el título de la tarea (R2) o la etiqueta del campo (R3); vacía en R1, R4 y R5.
- No se repite el par (`edicion_id`, `usuario_id`) en `inscripciones`, ni el par (`edicion_id`, `codigo`).
- No se guardan datos calculados: inscritos, asistentes, cupos libres, fechas límite, porcentaje reutilizado y recomendaciones se calculan.

## Relaciones

- Un usuario organiza muchas series.
- Una serie tiene muchas ediciones.
- Una edición puede nacer de otra edición, y una edición puede ser el origen de muchas.
- Una edición tiene muchos campos, mensajes, tareas, inscripciones y decisiones.
- Un usuario se inscribe en muchas ediciones y una edición tiene muchos inscritos, a través de inscripciones.
- Una inscripción tiene muchas respuestas, y un campo recibe muchas respuestas.
