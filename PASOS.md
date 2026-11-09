# PASOS · ProyectoSeminarioAlvaro, entrega 2

Haz los pasos en orden. Cada uno dice qué haces, qué revisas y qué respondes si el agente pregunta.

## Fase A · Montar el proyecto (15 min)

1. En la terminal, donde guardas tus proyectos:

   ```bash
   flutter create --platforms=web,android --project-name proyecto_seminario_alvaro ProyectoSeminarioAlvaro
   cd ProyectoSeminarioAlvaro
   ```

2. Descomprime `proyecto_seminario_alvaro_base.zip` **dentro** de `ProyectoSeminarioAlvaro/`. Acepta reemplazar `README.md`.
3. Revisa que existan: `AGENTS.md`, `PASOS.md`, la carpeta `docs/` (con `specs/` adentro) y `.agents/skills/` con 9 carpetas.
   - En Windows, `.agents` puede verse oculta: actívala en Vista → Elementos ocultos.
4. Corre `flutter pub get` y luego `flutter run -d chrome`. Debe salir el contador. Ciérralo con `q`.
5. Sube el proyecto a GitHub (repositorio del equipo):

   ```bash
   git init
   git add .
   git commit -m "Base: docs SDD, skills y contexto"
   git branch -M main
   git remote add origin https://github.com/USUARIO/ProyectoSeminarioAlvaro.git
   git push -u origin main
   ```

6. Abre el agente en la raíz del proyecto: `agy`.
7. Escribe `/permissions` → con Tab ve a **allowlist** → `A` → `write_file(*)` → Enter → **Project**. Repite con `command(*)`. Si prefieres aprobar cada comando, sáltate este paso.
8. Cierra el agente y ábrelo de nuevo (`agy`) para que cargue las skills.

## Fase B · Los 6 pedidos a Antigravity

Copia cada pedido tal cual. Al terminar cada uno:

- corre `flutter run -d chrome` y mira lo que dice "Revisa";
- haz un commit: `git add . && git commit -m "Pedido N"`. Los commits son tu evidencia de uso del agente.

### Pedido 1 · Criticar las specs (5 min)

```text
Lee AGENTS.md y todo docs/. Critica las specs.
```

- **Revisa:** se creó `docs/specs/reporte.md` con las métricas.
- **Si pregunta si aplica correcciones:** `Aplica solo las de redacción. No cambies reglas, fórmulas, números ni criterios de aceptación.`

### Pedido 2 · Modelos, datos simulados, lógica y pruebas (20 min)

```text
Lee docs/pantallas.md, docs/datos_simulados.md y las specs F-03, F-06, F-08 y F-09.
1. Borra test/widget_test.dart: es la prueba del contador de flutter create.
2. Crea los modelos de lib/models/ con copyWith, como dice docs/pantallas.md.
3. Crea lib/data/mock_data.dart con buildMockUsers() y buildMockSeries(DateTime today), exactamente con los datos de docs/datos_simulados.md. Las fechas son relativas a today.
4. Crea las funciones puras de lib/logic/ que lista docs/pantallas.md, con las fórmulas de las specs.
5. Crea test/logic_test.dart con un test por cada fila de "Resultados esperados" de docs/datos_simulados.md, con today = DateTime(2026, 11, 8).
6. Corre flutter test y flutter analyze y corrige hasta que todo pase. No cambies los resultados esperados para que pasen las pruebas: corrige la lógica o los datos.
```

- **Revisa:** `flutter test` dice `All tests passed!`.
- **Si dice que un resultado esperado está mal:** `Los resultados esperados están verificados. Revisa los datos simulados y la fórmula de la spec.`

### Pedido 3 · Acceso y navegación base (20 min)

```text
Usa la skill flutter-componentes y sigue docs/pantallas.md.
Construye: lib/main.dart (App, tema de docs/pantallas.md y rutas), CenteredBody, LoginScreen y RegisterScreen (spec F-01),
OrganizerMainScreen con SeriesPage y ProfilePage, NewSeriesScreen (F-02, pasos 1 a 3),
y AttendeeMainScreen con EventsPage, MyRegistrationsPage y ProfilePage (F-10 paso 1 y F-12).
Registra cada ruta cuando exista su pantalla. Abrir una serie o un evento todavía no navega: deja onOpen vacío, sin print.
Al terminar, corre flutter analyze y dime cómo probar con laura@eventos.co y valentina.rios@correo.co.
```

- **Revisa:** entras como Laura y ves 2 series; entras como Valentina y ves 2 eventos y 3 inscripciones pasadas; "Cerrar sesión" vuelve al login.

### Pedido 4 · Organizador: serie, nueva edición y recomendaciones (25 min)

```text
Usa la skill flutter-componentes y sigue docs/pantallas.md. Implementa F-02 (pasos 4 y 5), F-03, F-07, F-08 y F-09:
SeriesScreen, NewEditionScreen y EditionScreen, con StatusChip, EditionCard, EditionSummary, RecommendationCard y SectionButton.
EditionScreen muestra el resumen, el % reutilizado, las recomendaciones de lib/logic/recommendations.dart (con Aceptar y Descartar) y el botón Publicar o Cerrar según el estado.
Los SectionButton de Formulario, Mensajes, Tareas y Asistencia todavía no navegan: onTap: () {}.
Revisa la app contra los criterios de aceptación de esas specs con los datos simulados. Al terminar, flutter analyze y flutter test.
```

- **Revisa:** en la edición 4 salen "Abre 28 cupos", 2 tareas a adelantar, "Invita a 6 asistentes frecuentes" y "espera 6 asistentes". Al crear la edición 5, la fecha propuesta es hoy + 42 días y sale 100 % reutilizado.

### Pedido 5 · Organizador: formulario, mensajes, tareas y asistencia (25 min)

```text
Usa la skill flutter-componentes y sigue docs/pantallas.md. Implementa F-04, F-05, F-06 y F-13:
FormBuilderScreen, MessagesScreen, TasksScreen y AttendanceScreen, con FieldCard, FieldForm, MessageCard, MessageForm, TaskCard, TaskForm y AttendeeCard.
Conecta los SectionButton de EditionScreen a esas rutas: pushNamed con EditionArgs, await del resultado y setState con la edición que vuelve.
En una edición cerrada nada se puede cambiar.
Revisa la app contra los criterios de aceptación de esas specs. Al terminar, flutter analyze y flutter test.
```

- **Revisa:** "Publicar la invitación" sale "Atrasada"; la vista previa de la invitación reemplaza las variables; buscar "ospina" deja solo a Mariana Ospina.

### Pedido 6 · Invitado: detalle e inscripción, y revisión final (20 min)

```text
Usa la skill flutter-componentes y sigue docs/pantallas.md. Implementa F-10 y F-11:
EventCard en EventsPage, EventDetailScreen con RegistrationForm, y la creación de la inscripción en AttendeeMainScreen
(código con nextRegistrationCode y cambio a la pestaña Mis inscripciones).
Después revisa la app completa contra los criterios de aceptación de las 13 specs y dime cuáles no se cumplen y por qué.
Al terminar, flutter analyze y flutter test.
```

- **Revisa:** Valentina se inscribe en la edición 4, recibe R4-009 y la ve primera en "Mis inscripciones". El club dice "Sin cupos".

### Respuestas para cuando el agente pregunte

| Si pregunta o propone… | Responde |
|---|---|
| Agregar un paquete (`intl`, `provider`, `uuid`, `qr_flutter`…) | `No. AGENTS.md prohíbe paquetes nuevos. Usa lib/logic/.` |
| Usar Provider, Bloc o `InheritedWidget` | `No. Estado con setState en la Screen y funciones Function() hacia arriba.` |
| Usar `VoidCallback` o `ValueChanged` | `No. Usa Function() o Function(Tipo), como dice la skill flutter-componentes.` |
| Cambiar una spec o `docs/` | `No cambies docs/. Dime qué no cuadra y lo decido yo.` |
| Poner lógica dentro de un widget | `Muévela a lib/logic/ como función pura.` |
| `showDialog`, `SnackBar` o `showDatePicker` | `No. Muestra el mensaje en un Text dentro de la pantalla y la fecha en un TextField AAAA-MM-DD.` |
| Si algo queda a medias | `Termina el pedido anterior antes de seguir. Lista lo que falta.` |

## Fase C · Prototipo en Stitch → Figma (40 min, en paralelo)

1. Abre `docs/prototipo_stitch.md` y sigue "Cómo usarlo".
2. Genera las 15 pantallas, cópialas a Figma, ordénalas en la página "Prototipo" y deja la galería en la página "Galería".
3. Comparte el archivo de Figma con permiso de lectura para el profesor.
4. Opcional (5 min): en Figma → pestaña Prototype, une Login → Mis series → Serie → Edición 4 → Nueva edición.

## Fase D · Extra para la entrega 1 (5 min)

```text
Dibuja el MER de la app.
```

- **Revisa:** se creó `docs/mer.svg` con las 10 tablas de `docs/modelo.md`.

## Fase E · Sustentación (3 minutos)

1. **0:00** El problema en una frase y el ciclo de la sección 3 del README.
2. **0:30** Entra como Laura → serie "Ciclo de charlas" → edición 4: muestra las recomendaciones y lee una evidencia en voz alta. Acepta "Abre 28 cupos".
3. **1:15** Vuelve a la serie → "Nueva edición": fecha propuesta y 100 % reutilizado. Abre Tareas y muestra las fechas recalculadas.
4. **1:45** Asistencia: busca "R4-003" y marca a Mariana Ospina.
5. **2:05** Cierra sesión → entra como Valentina → se inscribe en la edición 4 → código R4-009.
6. **2:35** Uso de IA: `AGENTS.md`, `.agents/skills/`, `docs/specs/reporte.md`, `flutter test` pasando y los commits por pedido.

Explica que el estado vive en las Screens y los eventos suben con funciones, y que en el prototipo cada rol tiene su copia de los datos (en la entrega 3 los comparte Supabase).

## Fase F · Tráeme el código

Comprime `lib/`, `test/`, `docs/` y `pubspec.yaml` en un zip y mándamelo al chat. Te digo si usa bien las herramientas y los métodos del curso, y qué corregir antes de la sustentación.
