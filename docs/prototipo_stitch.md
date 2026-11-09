# Prototipo visual en Stitch → Figma

Prompts para generar en Google Stitch las pantallas de ProyectoSeminarioAlvaro y pasarlas a Figma. Usan los datos de `docs/datos_simulados.md`, para que el prototipo cuadre con el modelo de datos y con la app.

## Cómo usarlo

1. Entra a stitch.withgoogle.com con tu cuenta de Google.
2. Crea un proyecto en modo **App (Mobile)** con el modelo **Flash** (estándar). En Pro no aparece "Copy to Figma".
3. Pega primero el **Estilo base** junto con el prompt 1. Para las demás pantallas, en el mismo proyecto, pega solo su prompt.
4. Si una pantalla sale con algo que no está en el prompt (fotos, "me gusta", gráficos), pide: "Quita lo que no está en la descripción".
5. Selecciona la pantalla → **Copy to Figma** → en tu archivo de Figma "ProyectoSeminarioAlvaro · Prototipo", `Ctrl+V`.
6. En Figma: una página **Prototipo** con las pantallas en el orden de abajo y una página **Galería** con el prompt 15.

## Estilo base (pegar con el primer prompt)

```text
App móvil en español llamada "ProyectoSeminarioAlvaro" para organizar eventos recurrentes. Estilo Material 3 limpio y sobrio.
Fondo #FBFBFD, tarjetas blancas con borde #DCDDE6 y esquinas de 16 px, color principal índigo #4453C9.
Estados con chips: Borrador gris #79809A, Publicada verde #0F8478, Cerrada gris oscuro #454C61.
Recomendaciones en tarjetas ámbar: fondo #FFF3DC, borde #F0C572, título #A96C05.
Tipografía sans serif, títulos en negrita. Sin fotos de personas, sin ilustraciones, sin gráficos.
Barra superior simple con título y flecha de regreso cuando aplica.
```

## Organizador

**1 · Iniciar sesión**

```text
Pantalla de inicio de sesión. Logo de texto "ProyectoSeminarioAlvaro" con un ícono de calendario con flecha circular, en índigo.
Subtítulo: "La siguiente edición de tu evento, a partir de la anterior".
Campo "Correo" con laura@eventos.co escrito, campo "Contraseña" oculto.
Botón principal índigo "Entrar" a todo el ancho. Debajo, botón de texto "Crear cuenta".
```

**2 · Crear cuenta**

```text
Pantalla "Crear cuenta" con flecha de regreso. Campos: Nombre, Correo, Contraseña.
Pregunta "¿Cómo vas a usar la app?" con dos botones de selección lado a lado: "Organizo eventos" (seleccionado, índigo) y "Asisto a eventos" (contorno).
Botón principal "Crear cuenta". Mensaje de error rojo pequeño de ejemplo: "La contraseña debe tener al menos 6 caracteres".
```

**3 · Mis series**

```text
Pantalla "Mis series" con barra inferior de 2 pestañas: Series (activa) y Perfil.
Dos tarjetas de serie, una debajo de otra:
1) "Ciclo de charlas de analítica de datos" · 4 ediciones · Próxima: 15 nov 2026.
2) "Taller trimestral de primeros auxilios" · 1 edición · Sin próximas ediciones.
Botón flotante índigo con "+" y texto "Nueva serie".
```

**4 · Serie**

```text
Pantalla de la serie "Ciclo de charlas de analítica de datos" con flecha de regreso.
Descripción: "Charla mensual de una hora sobre analítica de datos aplicada, con un invitado de la industria."
Botón principal "Nueva edición".
Lista de tarjetas de edición, de la más reciente a la más antigua:
- Edición 4 · 15 nov 2026 · chip Publicada · 8 / 20 inscritos · 88 % reutilizado
- Edición 3 · 11 oct 2026 · chip Cerrada · 18 / 20 inscritos · 100 % reutilizado
- Edición 2 · 13 sep 2026 · chip Cerrada · 20 / 20 inscritos · 100 % reutilizado
- Edición 1 · 16 ago 2026 · chip Cerrada · 20 / 20 inscritos · 0 % reutilizado
```

**5 · Nueva edición**

```text
Pantalla "Nueva edición" con flecha de regreso.
Tarjeta informativa: "Basada en la Edición 4. Se copian 6 preguntas, 3 mensajes y 7 tareas."
Campos con valores ya escritos: Fecha "2026-12-20" con ayuda "Propuesta: tus ediciones van cada 35 días", Hora "18:00",
Lugar "Auditorio principal · Edificio A", Capacidad "20", Cupo "20".
Botón principal "Crear edición".
```

**6 · Edición (resumen y recomendaciones)**

```text
Pantalla "Edición 4 · 15 nov 2026" con flecha de regreso y chip Publicada.
Tarjeta resumen con 3 datos en fila: "8 / 20 inscritos", "Capacidad 20", "88 % reutilizado".
Sección "Recomendaciones" con 3 tarjetas ámbar, cada una con título, evidencia en texto pequeño y dos botones: "Aceptar" (lleno) y "Descartar" (texto):
- "Abre 28 cupos" — "En las últimas 3 ediciones asistieron 41 de 58 inscritos (71 %). Para llenar 20 lugares, abre 28 cupos."
- "Adelanta «Publicar la invitación» a D-13" — "Se completó tarde en 3 de 3 ediciones, en promedio 3 días."
- "Invita a 6 asistentes frecuentes" — "Asistieron a 2 o más de las últimas 3 ediciones y no se han inscrito."
Sección "Edición" con 4 botones de fila con ícono y detalle a la derecha: Formulario (6 preguntas), Mensajes (1 de 3 enviados), Tareas (2 de 7 hechas · 1 atrasada), Asistencia (0 de 8).
Botón de contorno al final: "Cerrar edición".
```

**7 · Formulario**

```text
Pantalla "Formulario · Edición 4" con flecha de regreso.
Lista de preguntas en tarjetas, cada una con etiqueta, tipo y etiquetas pequeñas:
Celular (Texto · Obligatoria · Heredada), Empresa u organización (Texto · Heredada), Cargo (Texto · Heredada),
¿Cómo te enteraste del evento? (Texto · Heredada), ¿Necesitas certificado? (Sí/No · Heredada),
¿Tienes alguna restricción alimentaria? (Texto · Nueva). Cada tarjeta con ícono de papelera.
Al final, formulario "Agregar pregunta": campo Etiqueta, tres botones de tipo (Texto, Número, Sí/No), botones "Obligatoria" / "Opcional" y botón "Agregar".
```

**8 · Mensajes**

```text
Pantalla "Mensajes · Edición 4" con flecha de regreso.
Tres tarjetas ordenadas por fecha, cada una con tipo, "D-12 · 3 nov", asunto, vista previa del texto y estado:
- Invitación · D-12 · 3 nov · "Te esperamos en Ciclo de charlas de analítica de datos · Edición 4" · vista previa "Hola invitado: el 15 nov 2026 a las 18:00 tendremos…" · chip verde "Enviado".
- Recordatorio · D-1 · 14 nov · "Mañana es Ciclo de charlas…" · botón "Marcar enviado".
- Agradecimiento · D+1 · 16 nov · "Gracias por venir a Ciclo de charlas…" · botón "Marcar enviado".
Al final, formulario "Agregar mensaje": Tipo, Días respecto al evento, Asunto, Cuerpo (varias líneas) con ayuda "Variables: {evento} {fecha} {hora} {lugar} {nombre}" y botón "Agregar".
```

**9 · Tareas**

```text
Pantalla "Tareas · Edición 4" con flecha de regreso. Resumen arriba: "2 de 7 hechas · 1 atrasada".
Lista de tarjetas con casilla redonda, título, responsable y fecha límite:
- Reservar el auditorio · Laura · D-21 · 25 oct · Hecha (tachada en gris)
- Confirmar al conferencista · Laura · D-14 · 1 nov · Hecha
- Publicar la invitación · Comunicaciones · D-10 · 5 nov · en rojo "Atrasada 3 días"
- Pedir los refrigerios · Logística · D-3 · 12 nov · Pendiente
- Imprimir la lista de asistencia · Logística · D-1 · 14 nov · Pendiente
- Probar el video beam · Logística · D-1 · 14 nov · Pendiente · etiqueta "Nueva"
- Enviar el agradecimiento · Comunicaciones · D+2 · 17 nov · Pendiente
Formulario al final: Tarea, Responsable, Días respecto al evento, botón "Agregar".
```

**10 · Asistencia**

```text
Pantalla "Asistencia · Edición 4" con flecha de regreso. Resumen: "1 de 8 asistieron".
Buscador con ícono de lupa y texto "Busca por nombre o código".
Lista de tarjetas: nombre, correo pequeño, código en una etiqueta y botón a la derecha:
Andrés Quintero · R4-004 · "Marcar asistencia"; Daniela Castillo · R4-001 · "Marcar asistencia";
Felipe Cardona · R4-002 · "Marcar asistencia"; Mariana Ospina · R4-003 · chip verde "Asistió"; Mateo Salazar · R4-008 · "Marcar asistencia".
```

## Invitado

**11 · Eventos**

```text
Pantalla "Eventos" para el invitado, con barra inferior de 3 pestañas: Eventos (activa), Mis inscripciones, Perfil.
Saludo "Hola, Valentina".
Dos tarjetas de evento:
- "Ciclo de charlas de analítica de datos · Edición 4" · dom 15 nov 2026 · 18:00 · Auditorio principal · Edificio A · etiqueta verde "Quedan 12 cupos".
- "Club de lectura de ingeniería · Edición 1" · dom 22 nov 2026 · 19:00 · Biblioteca · Sala 3 · etiqueta gris "Sin cupos".
```

**12 · Detalle e inscripción**

```text
Pantalla de detalle del evento "Ciclo de charlas de analítica de datos · Edición 4" con flecha de regreso.
Descripción de la serie, fecha, hora, lugar y "Quedan 12 cupos".
Sección "Inscríbete": campos Celular *, Empresa u organización, Cargo, ¿Cómo te enteraste del evento?, ¿Tienes alguna restricción alimentaria?,
y la pregunta "¿Necesitas certificado?" con dos botones "Sí" y "No".
Nota pequeña: "Tu nombre y correo se toman de tu cuenta". Botón principal "Confirmar inscripción".
```

**13 · Mis inscripciones**

```text
Pantalla "Mis inscripciones" con la pestaña central activa.
Sección "Próximas": tarjeta "Ciclo de charlas de analítica de datos · Edición 4" · 15 nov 2026 · código grande "R4-009" · chip índigo "Próximo".
Sección "Pasadas": tres tarjetas de las ediciones 3, 2 y 1 del mismo ciclo, con sus fechas y chip verde "Asististe".
```

**14 · Perfil**

```text
Pantalla "Perfil" con la pestaña Perfil activa. Avatar circular con iniciales "VR", nombre "Valentina Ríos", correo valentina.rios@correo.co,
etiqueta "Invitada". Botón de contorno rojo "Cerrar sesión".
```

## Galería de componentes (entrega 1)

**15 · Galería**

```text
Una sola pantalla larga titulada "Galería de componentes · ProyectoSeminarioAlvaro", con cada componente una sola vez y su nombre encima en texto pequeño gris:
StatusChip (tres variantes: Borrador, Publicada, Cerrada), SeriesCard, EditionCard, EditionSummary,
RecommendationCard (normal), SectionButton, FieldCard (heredada y nueva), MessageCard (enviado y pendiente),
TaskCard (pendiente, hecha y atrasada), AttendeeCard (sin marcar y asistió), EventCard (con cupos y sin cupos),
RegistrationCard (próximo, asististe y no asististe), botón principal, botón de contorno, campo de texto normal y con error,
EmptyMessage ("Todavía no tienes series. Crea la primera."), barra inferior de navegación.
Usa los mismos datos de las pantallas anteriores.
```
