# Datos simulados del prototipo

Fuente única de `lib/data/mock_data.dart` y de los resultados esperados de `test/logic_test.dart`.
Todas las fechas son **relativas a hoy** (`hoy`). En la app, `hoy` = `DateTime.now()`; en los tests, `hoy` = 8 nov 2026.
Las fechas entre paréntesis son las que salen con hoy = 8 nov 2026.

## Cuentas

Todas con contraseña `123456`.

| Id | Nombre | Correo | Rol |
|---|---|---|---|
| u-laura | Laura Gómez | laura@eventos.co | organizador |
| u-jorge | Jorge Ramírez | jorge@eventos.co | organizador |
| p01 | Ana María Torres | ana.torres@correo.co | invitado |
| p02 | Juan David Rojas | juan.rojas@correo.co | invitado |
| p03 | Camila Herrera | camila.herrera@correo.co | invitado |
| p04 | Santiago Morales | santiago.morales@correo.co | invitado |
| p05 | Daniela Castillo | daniela.castillo@correo.co | invitado |
| p06 | Felipe Cardona | felipe.cardona@correo.co | invitado |
| p07 | Mariana Ospina | mariana.ospina@correo.co | invitado |
| p08 | Andrés Quintero | andres.quintero@correo.co | invitado |
| p09 | Paula Andrea Vélez | paula.velez@correo.co | invitado |
| p10 | Sebastián Muñoz | sebastian.munoz@correo.co | invitado |
| p11 | Natalia Guzmán | natalia.guzman@correo.co | invitado |
| p12 | Mateo Salazar | mateo.salazar@correo.co | invitado |
| p13 | Valentina Ríos | valentina.rios@correo.co | invitado |
| p14 | Julián Arango | julian.arango@correo.co | invitado |
| p15 | Isabella Zapata | isabella.zapata@correo.co | invitado |
| p16 | Nicolás Restrepo | nicolas.restrepo@correo.co | invitado |
| p17 | Sara Londoño | sara.londono@correo.co | invitado |
| p18 | Tomás Giraldo | tomas.giraldo@correo.co | invitado |
| p19 | Manuela Duque | manuela.duque@correo.co | invitado |
| p20 | Alejandro Pineda | alejandro.pineda@correo.co | invitado |
| p21 | Gabriela Montoya | gabriela.montoya@correo.co | invitado |
| p22 | Esteban Correa | esteban.correa@correo.co | invitado |
| p23 | Luisa Fernanda Ruiz | luisa.ruiz@correo.co | invitado |
| p24 | David Escobar | david.escobar@correo.co | invitado |
| p25 | Carolina Mesa | carolina.mesa@correo.co | invitado |

Para la demo: organizadora **laura@eventos.co**, invitada **valentina.rios@correo.co**.

## Serie A · Ciclo de charlas de analítica de datos (de Laura)

Descripción: "Charla mensual de una hora sobre analítica de datos aplicada, con un invitado de la industria."
Todas las ediciones: 18:00, "Auditorio principal · Edificio A", capacidad 20, cupo 20.

| Edición | Fecha | Estado | Nace de | Inscritos | Asistieron |
|---|---|---|---|---|---|
| 1 | hoy − 84 (16 ago) | cerrada | desde cero | p01–p20 (20) | p01–p14 (14) |
| 2 | hoy − 56 (13 sep) | cerrada | edición 1 | p03–p22 (20) | p03–p16 (14) |
| 3 | hoy − 28 (11 oct) | cerrada | edición 2 | p05–p22 (18) | p05–p17 (13) |
| 4 | hoy + 7 (15 nov) | publicada | edición 3 | p05–p12 (8) | nadie todavía |

- La edición 1 tiene todo con `heredado = false`; las ediciones 2, 3 y 4 tienen todo lo copiado con `heredado = true`.
- Códigos: dentro de cada edición, por número de persona ascendente, `R{edición}-001`, `R{edición}-002`… (en la 4: p05 = R4-001, p06 = R4-002, p07 = R4-003…).
- Fecha de inscripción de la persona i: fecha del evento − (2 + i % 10) días.

### Preguntas (ediciones 1 a 4)

| Orden | Etiqueta | Tipo | Obligatoria | Quién responde (persona número i) | Respuesta |
|---|---|---|---|---|---|
| 1 | Celular | texto | sí | todos | "300 555 01" + i con dos dígitos (p13 → "300 555 0113") |
| 2 | Empresa u organización | texto | no | i % 4 != 0 | "Organización " + i |
| 3 | Cargo | texto | no | i % 7 == 0 | "Analista de datos" |
| 4 | ¿Cómo te enteraste del evento? | texto | no | i % 6 == 0 | "Por un colega" |
| 5 | ¿Necesitas certificado? | si_no | no | i impar | "Sí" si i % 4 == 1, si no "No" |
| 6 | ¿Tienes alguna restricción alimentaria? | texto | no | i % 5 == 0 | "Vegetariano" |

La pregunta 6 **solo existe en la edición 4** y es **no heredada** (se agregó a mano).

### Mensajes (ediciones 1 a 4)

| Tipo | Días | Asunto | Cuerpo |
|---|---|---|---|
| invitacion | −12 | Te esperamos en {evento} | Hola {nombre}: el {fecha} a las {hora} tendremos {evento} en {lugar}. Inscríbete desde la app; los cupos son limitados. |
| recordatorio | −1 | Mañana es {evento} | Hola {nombre}: te esperamos mañana a las {hora} en {lugar}. Ten a mano tu código de inscripción. |
| agradecimiento | +1 | Gracias por venir a {evento} | Hola {nombre}: gracias por acompañarnos. Pronto te contamos la fecha de la próxima edición. |

En las ediciones 1 a 3 los tres están enviados. En la 4 solo la invitación está enviada.

### Tareas

Fecha en que se hizo = fecha del evento + días + retraso.

| Título | Responsable | Días | Retraso ed. 1 | Retraso ed. 2 | Retraso ed. 3 | Edición 4 |
|---|---|---|---|---|---|---|
| Reservar el auditorio | Laura | −21 | +4 | +3 | +5 | hecha con retraso +3 (D-18) |
| Confirmar al conferencista | Laura | −14 | −1 | 0 | −2 | hecha con retraso 0 (D-14) |
| Publicar la invitación | Comunicaciones | −10 | +3 | +2 | +4 | pendiente |
| Pedir los refrigerios | Logística | −3 | 0 | +1 | 0 | pendiente |
| Imprimir la lista de asistencia | Logística | −1 | 0 | 0 | −1 | pendiente |
| Enviar el agradecimiento | Comunicaciones | +2 | 0 | +2 | +1 | pendiente |
| Probar el video beam | Logística | −1 | — | — | — | pendiente, **no heredada** (solo en la 4) |

## Serie B · Taller trimestral de primeros auxilios (de Laura)

Descripción: "Taller práctico de primeros auxilios básicos para personal administrativo."

- Edición 1: hoy − 70 (30 ago), 09:00, "Salón 204 · Edificio B", capacidad 15, cupo 15, **cerrada**, desde cero.
- Inscritos p01–p10 (R1-001…R1-010); asistieron p01–p08.
- Preguntas: "Celular" (texto, obligatoria, como en la serie A) y "¿Tienes formación previa en primeros auxilios?" (si_no, opcional; responde "Sí" si i % 3 == 0, los demás la dejan vacía).
- Mensajes: invitacion −10 y recordatorio −1, con los mismos textos de la serie A; ambos enviados.
- Tareas: "Reservar el salón" (Laura, −10, hecha en D-11) y "Conseguir los maniquíes" (Logística, −5, hecha en D-3).

## Serie C · Club de lectura de ingeniería (de Jorge)

Descripción: "Encuentro para comentar un libro técnico en cada edición."

- Edición 1: hoy + 14 (22 nov), 19:00, "Biblioteca · Sala 3", capacidad 12, cupo 12, **publicada**, desde cero.
- Inscritos p14–p25 (12 de 12: **sin cupos**), nadie ha asistido.
- Pregunta: "Celular" (texto, obligatoria).
- Mensaje: invitacion −14, enviado.
- Tareas: "Elegir el libro" (Jorge, −21, hecha en D-25) y "Reservar la sala" (Jorge, −7, pendiente).

## Resultados esperados (hoy = 8 nov 2026)

Son los casos de `test/logic_test.dart`. "Edición 5" = clon de la edición 4 de la serie A con fecha 20 dic 2026, sin aceptar ninguna recomendación antes.

| Qué se prueba | Resultado |
|---|---|
| Historial de la edición 4 (y de la 5) | ediciones 1, 2 y 3 de la serie A |
| Tasa de asistencia del historial | 41 / 58 = 0,7069 (71 %) |
| R1 en la edición 4 | cupo sugerido 28 (cupo actual 20) |
| R2 en la edición 4 | "Publicar la invitación" −10 → −13 (promedio 3); "Enviar el agradecimiento" +2 → +1 (promedio 1). Nada para "Reservar el auditorio" (ya está hecha) |
| R2 en la edición 5 | lo anterior más "Reservar el auditorio" −21 → −25 (promedio 4) |
| R3 en la edición 4 | ninguna ("Cargo" tiene 1 respuesta y "¿Cómo te enteraste del evento?" tiene 2 en la 4) |
| R3 en la edición 5 | "Cargo" 8 / 58 (14 %) y "¿Cómo te enteraste del evento?" 9 / 58 (16 %) |
| R4 en la edición 4 | 6 personas: Camila Herrera, Isabella Zapata, Julián Arango, Nicolás Restrepo, Santiago Morales, Valentina Ríos |
| R4 en la edición 5 | 14 personas (p03 a p16) |
| R5 en la edición 4 | 6 asistentes esperados (8 × 0,7069 = 5,66 → 6) |
| R5 en la edición 5 | no aplica (0 inscritos) |
| Reutilizado | ed. 1: 0 % · ed. 2: 100 % · ed. 3: 100 % · ed. 4: 88 % (14 de 16) · ed. 5: 100 % (16 de 16) |
| R1 en la edición 5 si antes se cierra la 4 sin asistentes marcados | historial = ediciones 2, 3 y 4; asistieron 27 de 46 (59 %); cupo sugerido 34 |
| Fecha propuesta para la edición 5 | 20 dic 2026 (15 nov + 35 días) |
| Fecha propuesta para la edición 2 de la serie B | 15 nov 2026 (30 ago + 30 días ya pasó → hoy + 7) |
| Recomendaciones en la edición 2 de la serie B | ninguna: el historial tiene 1 edición cerrada |
| Fecha límite de "Reservar el auditorio" en la edición 5 | 29 nov 2026 |
| Tarea atrasada en la edición 4 | "Publicar la invitación", 3 días |
| Siguiente código en la edición 4 | R4-009 |
| Vista previa de la invitación de la edición 4 | "Hola invitado: el 15 nov 2026 a las 18:00 tendremos Ciclo de charlas de analítica de datos · Edición 4 en Auditorio principal · Edificio A. Inscríbete desde la app; los cupos son limitados." |
| Eventos que ve Valentina | edición 4 de la serie A (12 cupos libres) y edición 1 de la serie C (0 cupos) |
