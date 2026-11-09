# ProyectoSeminarioAlvaro

## Qué es

App para organizar eventos recurrentes (charlas mensuales, talleres trimestrales). Cada evento es una **serie** con **ediciones** numeradas. Una edición nueva se crea copiando la anterior: preguntas del formulario, mensajes y tareas, con fechas relativas al día del evento. Con las ediciones cerradas, la app hace 5 recomendaciones por reglas fijas (cupo, tareas que se atrasan, preguntas que nadie responde, invitados frecuentes y asistencia esperada).
Dos roles: **organizador** (en el PC, navegador) e **invitado** (en el celular): ve eventos, se inscribe y recibe un código.
No hay IA en la app, no se envían correos (los mensajes se copian), no hay pagos, certificados ni QR.

## Cómo se ejecuta y se revisa

- Ejecutar: `flutter run -d chrome` (y en Android con el emulador).
- Revisar: `flutter analyze`. No debe quedar ningún aviso en `lib/` ni en `test/`.
- Probar la lógica: `flutter test`.

## Estructura

- `lib/main.dart`: la app (`App`), el tema y la tabla de rutas.
- `lib/models/`: modelos inmutables con `copyWith`.
- `lib/data/mock_data.dart`: datos simulados (entrega 2).
- `lib/logic/`: reglas en funciones puras.
- `lib/components/`, `lib/pages/`, `lib/screens/`.
- `test/logic_test.dart`: pruebas de la lógica.

## Documentos

- `docs/prd.md`, `docs/requisitos.md`, `docs/architectural_spine.md`: qué y por qué.
- `docs/specs/`: una spec por funcionalidad. Es el contrato: el código hace lo que dice la spec.
- `docs/modelo.md`: el modelo de datos. No inventes atributos.
- `docs/pantallas.md`: carpetas, modelos, rutas, quién guarda estado, componentes y colores. **Léelo antes de escribir código.**
- `docs/datos_simulados.md`: los datos de `mock_data.dart` y los resultados que deben dar las pruebas.

## Convenciones

- Usa la skill `flutter-componentes` para todo componente, Page o Screen. Las pantallas de este proyecto tienen estado y navegación: no uses `flutter-pantallas`.
- Estado solo con `StatefulWidget` y `setState`, en la Screen o en un formulario. Prohibido: Provider, Riverpod, Bloc, Cubit, GetX, `InheritedWidget` y cualquier paquete de estado.
- Los datos bajan por el constructor; los eventos suben con `Function()` o `Function(Tipo)`. Nunca `VoidCallback` ni `ValueChanged`.
- Solo la Screen llama al `Navigator`. Solo rutas nombradas; los datos viajan en `arguments` y vuelven con `pop`.
- Las Pages de cada `MainScreen` van en un `IndexedStack` con `BottomNavigationBar`.
- Toda Screen tiene `Scaffold`, y su `body` es un `CenteredBody`.
- La lógica va en `lib/logic/` y nunca en un widget. Recibe `today` como parámetro; la Screen pasa `DateTime.now()`.
- Todo `TextEditingController` tiene su `dispose()`.
- Imports con `package:proyecto_seminario_alvaro/`. Código en inglés; textos de la interfaz en español. Una línea `///` sobre cada clase pública; sin más comentarios.

## Reglas para el agente

- No agregues paquetes a `pubspec.yaml`. En la entrega 2 no hay ninguno además de los que trae `flutter create`.
- No cambies `docs/` salvo que te lo pidan. Si una spec no cuadra con el código, avisa: no la corrijas por tu cuenta.
- No borres código que ya existe sin preguntar.
- Si algo de lo pedido rompe una convención, no lo hagas: di cuál y propón cómo hacerlo dentro de las reglas.
- Al terminar cada pedido: ejecuta `flutter analyze` (y `flutter test` si tocaste `lib/logic/` o `lib/models/`) y di qué archivos creaste o cambiaste.
