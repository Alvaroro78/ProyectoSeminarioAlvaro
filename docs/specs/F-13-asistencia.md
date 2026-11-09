---
id: F-13
titulo: Registro de asistencia
version: 0.1.0
fecha: 2026-11-08
estado: borrador
autores: [Álvaro José Roa Álvarez]
requisitos: [RF-22, RF-23]
depende_de: [F-07, F-11]
---

# F-13 · Registro de asistencia

## Objetivo

El día del evento, el organizador encuentra a cada inscrito por su nombre o por su código y marca que asistió. Esa asistencia alimenta las recomendaciones de las ediciones siguientes.

## Flujo principal

1. El organizador abre los inscritos de una edición publicada. Ve nombre, correo, código y si asistió, ordenados por nombre, y el resumen "N de M asistieron".
2. Escribe en el buscador parte del nombre o del código. La lista muestra solo a quienes coinciden.
3. Marca la asistencia de un inscrito con un toque. El sistema lo muestra como "Asistió" y actualiza el resumen.
4. Si se equivocó, desmarca la asistencia con otro toque.

## Flujos alternos

- **A1 · Sin coincidencias:** "Nadie coincide con «texto»".
- **A2 · Edición cerrada:** la lista se ve, pero la asistencia no se puede cambiar.

## Reglas

- La búsqueda no distingue mayúsculas de minúsculas.
- La asistencia solo se cambia en ediciones publicadas.

## Estados

- **Cargando:** "Cargando inscritos…".
- **Vacío:** "Nadie se ha inscrito todavía."
- **Error:** "No se pudo guardar la asistencia." La marca vuelve a como estaba.

## Datos

- Inscrito: nombre, correo, código, asistió.

## Criterios de aceptación

Con los datos simulados:

- **CA-1** Dado la edición 4, cuando el organizador escribe "R4-003", entonces la lista muestra solo a Mariana Ospina.
- **CA-2** Dado la edición 4, cuando el organizador escribe "ospina", entonces la lista muestra solo a Mariana Ospina.
- **CA-3** Dado la edición 4 con 0 asistentes, cuando el organizador marca la asistencia de Mariana Ospina, entonces ella aparece como "Asistió" y el resumen dice "1 de 8 asistieron".
- **CA-4** Dado la edición 3, cerrada, cuando el organizador abre sus inscritos, entonces no puede cambiar la asistencia.

## Fuera de alcance

- Leer un código QR con la cámara.
- Marcar asistencia desde dos o más dispositivos a la vez.

## Preguntas abiertas

- ¿La búsqueda debe ignorar las tildes?

## Historial

- 0.1.0 · 2026-11-08 · Primera versión.
