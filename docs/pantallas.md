# Plan del prototipo · entrega 2

Cómo se construye lo que dicen las specs, con las reglas del curso. Las specs dicen **qué**; este documento dice **cómo**.

## Carpetas

```text
lib/
├── main.dart              # App, tema y tabla de rutas
├── models/                # Datos inmutables con copyWith
├── data/mock_data.dart    # buildMockUsers() y buildMockSeries(today), de docs/datos_simulados.md
├── logic/                 # Funciones puras: sin widgets, sin setState, sin Navigator
├── components/            # StatelessWidget, salvo los formularios
├── pages/                 # Las pestañas de cada MainScreen (StatelessWidget)
└── screens/               # Las únicas que guardan estado y navegan
test/
└── logic_test.dart        # Resultados esperados de docs/datos_simulados.md
```

## Modelos (`lib/models/`)

Código en inglés. Todos inmutables (`final`), con constructor `const` cuando se pueda y `copyWith`. Las listas se reemplazan, no se modifican.

| Modelo | Tabla | Campos |
|---|---|---|
| `AppUser` | usuarios | id, name, email, password (solo en el prototipo), role (`'organizer'` o `'attendee'`) |
| `EventSeries` | series | id, organizerId, name, description, editions (`List<Edition>`) |
| `Edition` | ediciones | id, seriesId, sourceEditionId (`String?`), number, dateTime, place, capacity, quota, status (`'draft'`, `'published'`, `'closed'`), fields, messages, tasks, registrations, decisions |
| `RegistrationField` | campos | id, label, type (`'text'`, `'number'`, `'yesNo'`), isRequired, order, inherited |
| `EventMessage` | mensajes | id, type (`'invitation'`, `'reminder'`, `'thanks'`, `'other'`), subject, body, offsetDays, sent, inherited |
| `EventTask` | tareas | id, title, owner, offsetDays, doneAt (`DateTime?`), inherited |
| `Registration` | inscripciones + respuestas | id, userId, userName, userEmail, code, registeredAt, attended, answers (`Map<String, String>`: id de la pregunta → respuesta) |
| `Decision` | decisiones | rule (`'R1'`…`'R5'`), reference, accepted, decidedAt |
| `Recommendation` | (se calcula) | rule, reference, title, evidence, actionLabel, value (`int?`), people (`List<String>`, "Nombre · correo") |
| `EditionArgs` | (navegación) | series (`EventSeries`), edition (`Edition`) |
| `EventArgs` | (navegación) | series, edition, user (`AppUser`) |

`userName` y `userEmail` se copian en `Registration` solo para mostrarlos en el prototipo; en la base es `usuario_id`.
Para `copyWith` de un campo que puede ser `null` (`doneAt`), agrega un parámetro `bool clearDoneAt = false`.

## Lógica (`lib/logic/`)

Funciones puras. La que necesita la fecha de hoy la recibe como parámetro `today`.

- `dates.dart`: `dueDate(eventDate, offsetDays)`, `daysBetween(a, b)` por fecha de calendario, `formatDate(d)` → "15 nov 2026", `formatShortDate(d)` → "15 nov", `formatTime(d)` → "18:00", `formatOffset(days)` → "D-12", "Día del evento" o "D+2", `parseDate("2026-12-20")` → `DateTime?`, `parseTime("18:00")`.
- `templates.dart`: `fillTemplate(text, values)` reemplaza `{clave}`; `messageValues(series, edition)` arma el mapa de F-05.
- `cloning.dart`: `proposeDate(series, today)`, `cloneEdition(base, newId, dateTime, place, capacity, quota)`, `firstEdition(seriesId, newId, dateTime, place, capacity, quota)`, `canPublish(edition, today)`.
- `savings.dart`: `reusedPercent(edition)`.
- `registrations.dart`: `freeSpots(edition)`, `nextRegistrationCode(edition)`, `isRegistered(edition, userId)`, `missingRequired(edition, answers)`.
- `recommendations.dart`: `historyFor(series, edition)`, `attendanceRate(history)`, `buildRecommendations(series, edition)` (R1 a R5, sin las ya decididas), `acceptRecommendation(edition, rec, today)`, `discardRecommendation(edition, rec, today)`.

Las fórmulas exactas están en las specs F-03, F-06, F-08 y F-09. Los números que deben salir están en `docs/datos_simulados.md`.

## Rutas (`lib/main.dart`)

Toda pantalla que edita algo lo recibe en `arguments`, guarda una copia en su estado y la devuelve con `Navigator.pop(context, copia)` al tocar la flecha de atrás del `AppBar`.

| Ruta | Screen | `arguments` | Devuelve con `pop` | Specs |
|---|---|---|---|---|
| `/` | `LoginScreen` | — | — | F-01 |
| `/register` | `RegisterScreen` | `List<String>` con los correos que ya existen | `AppUser` | F-01 |
| `/organizer` | `OrganizerMainScreen` | `AppUser` | — | F-02 |
| `/series/new` | `NewSeriesScreen` | `List<String>` con los nombres de sus series | `EventSeries` | F-02 |
| `/series` | `SeriesScreen` | `EventSeries` | `EventSeries` | F-02 |
| `/editions/new` | `NewEditionScreen` | `EventSeries` | `Edition` | F-03 |
| `/editions` | `EditionScreen` | `EditionArgs` | `Edition` | F-07, F-08, F-09 |
| `/editions/form` | `FormBuilderScreen` | `EditionArgs` | `Edition` | F-04 |
| `/editions/messages` | `MessagesScreen` | `EditionArgs` | `Edition` | F-05 |
| `/editions/tasks` | `TasksScreen` | `EditionArgs` | `Edition` | F-06 |
| `/editions/attendance` | `AttendanceScreen` | `EditionArgs` | `Edition` | F-13 |
| `/attendee` | `AttendeeMainScreen` | `AppUser` | — | F-10, F-12 |
| `/events/detail` | `EventDetailScreen` | `EventArgs` | `Map<String, String>` con las respuestas | F-10, F-11 |

- Entrar y cerrar sesión usan `pushNamedAndRemoveUntil`.
- En las Screens con copia en el estado, la copia se toma una sola vez: `_edition ??= (ModalRoute.of(context)!.settings.arguments as EditionArgs).edition;` dentro de `build`.
- El botón atrás del sistema descarta los cambios de esa pantalla. Es aceptable en el prototipo.

## Quién guarda el estado

| Screen | Estado |
|---|---|
| `LoginScreen` | `_users` (de `buildMockUsers()`), controllers, `_error` |
| `RegisterScreen` | controllers, rol elegido, `_error` |
| `OrganizerMainScreen` | `_series` (las del organizador, de `buildMockSeries(DateTime.now())`), `_index` |
| `SeriesScreen` | `_series` (copia) |
| `NewEditionScreen` | controllers, `_error` |
| `EditionScreen` | `_edition` (copia), `_shownPeople` (la lista de R4 aceptada, para mostrarla) |
| `FormBuilderScreen`, `MessagesScreen`, `TasksScreen` | `_edition` (copia) |
| `AttendanceScreen` | `_edition` (copia), controller del buscador, `_query` |
| `AttendeeMainScreen` | `_series` (todas), `_index` |

En el prototipo cada rol trabaja sobre su propia copia de los datos simulados: lo que inscribe Valentina no lo ve Laura en la misma ejecución. En la entrega 3 la fuente común es la base de datos.

## Pages (`lib/pages/`)

- `OrganizerMainScreen`, con `BottomNavigationBar` e `IndexedStack`: `SeriesPage` (series + `onOpen`) y `ProfilePage` (usuario + `onLogout`). El `FloatingActionButton` "Nueva serie" solo en la pestaña 0.
- `AttendeeMainScreen`, con `BottomNavigationBar` e `IndexedStack`: `EventsPage` (eventos + `onOpen`), `MyRegistrationsPage` (inscripciones) y `ProfilePage`. Al volver del detalle con respuestas, la Screen crea la `Registration` (con `nextRegistrationCode`), la agrega a la edición y pasa a la pestaña 1.

## Componentes (`lib/components/`)

Esta es también la galería de la entrega 1.

| Componente | Recibe | Avisa |
|---|---|---|
| `CenteredBody` | child | — |
| `StatusChip` | status | — |
| `SeriesCard` | series | `onTap` |
| `EditionCard` | edition, reusedPercent | `onTap` |
| `EditionSummary` | inscritos, cupo, capacidad, % reutilizado, estado | — |
| `RecommendationCard` | recommendation | `onAccept`, `onDiscard` |
| `SectionButton` | icono, título, detalle | `onTap` |
| `FieldCard` | field, answersCount, canEdit | `onDelete` |
| `FieldForm` (Stateful) | — | `onAdd(RegistrationField)` |
| `MessageCard` | message, preview, sendDateText, canEdit | `onToggleSent`, `onDelete` |
| `MessageForm` (Stateful) | — | `onAdd(EventMessage)` |
| `TaskCard` | task, dueText, statusText, canEdit | `onToggleDone`, `onDelete` |
| `TaskForm` (Stateful) | — | `onAdd(EventTask)` |
| `AttendeeCard` | registration, canEdit | `onToggleAttended` |
| `EventCard` | series, edition, spotsText | `onTap` |
| `RegistrationCard` | evento, fecha, código, estado | — |
| `RegistrationForm` (Stateful) | fields | `onSubmit(Map<String, String>)` |
| `EmptyMessage` | texto | — |

- `CenteredBody` va en todo `body`: `SafeArea` → `SingleChildScrollView(padding: 16)` → `Center` → `Container(constraints: BoxConstraints(maxWidth: 600))`. Así en el PC se ve centrado y en el celular a lo ancho.
- Si `canEdit` es `false`, el componente no muestra sus botones de acción.
- Las preguntas de sí/no se responden con dos botones ("Sí" y "No"), sin `Switch` ni `Checkbox`.

## Colores (`ThemeData` en `main.dart`)

- `seedColor`: `Color(0xFF4453C9)` (índigo), `useMaterial3: true`, fondo `Color(0xFFFBFBFD)`.
- Estados: borrador gris `Color(0xFF79809A)`, publicada verde `Color(0xFF0F8478)`, cerrada `Color(0xFF454C61)`.
- Tarjeta de recomendación: fondo `Color(0xFFFFF3DC)`, borde `Color(0xFFF0C572)`, título `Color(0xFFA96C05)`.
- Atrasada: `Colors.red`.
