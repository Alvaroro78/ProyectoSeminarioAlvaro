---
id: F-02
titulo: Series de eventos
version: 0.1.0
fecha: 2026-11-08
estado: borrador
autores: [Álvaro José Roa Álvarez]
requisitos: [RF-01, RF-02]
depende_de: [F-01]
---

# F-02 · Series de eventos

## Objetivo

El organizador agrupa en una serie todas las ediciones de un mismo evento recurrente, para ver su historia en un solo lugar.

## Flujo principal

1. El organizador ve sus series. Cada una muestra su nombre, cuántas ediciones tiene y la fecha de la próxima edición.
2. Pide una serie nueva y escribe su nombre y su descripción.
3. El sistema la agrega a la lista, sin ediciones.
4. El organizador abre una serie y ve su descripción y sus ediciones, de la más reciente a la más antigua. Cada edición muestra número, fecha, estado, inscritos sobre cupo y porcentaje reutilizado.
5. Desde la serie, el organizador pide una edición nueva (F-03) o abre una existente.

## Flujos alternos

- **A1 · Nombre vacío:** el sistema muestra "Escribe el nombre de la serie" y no crea nada.
- **A2 · Nombre repetido:** el sistema muestra "Ya tienes una serie con ese nombre" y no crea nada.

## Reglas

- El organizador solo ve las series que él creó.
- El nombre de la serie no se repite entre las series del mismo organizador.
- La próxima edición es la edición en borrador o publicada con la fecha más cercana desde hoy en adelante. Si no hay, se muestra "Sin próximas ediciones".
- El nombre de una edición es "nombre de la serie · Edición N".

## Estados

- **Cargando:** la lista muestra "Cargando series…".
- **Vacío:** sin series, "Todavía no tienes series. Crea la primera." En una serie sin ediciones, "Esta serie no tiene ediciones. Crea la primera."
- **Error:** los mensajes de A1 y A2, debajo del formulario.

## Datos

- Serie: nombre, descripción, organizador.
- Edición (resumen): número, fecha, estado, inscritos, cupo, porcentaje reutilizado.

## Criterios de aceptación

- **CA-1** Dado un organizador sin series, cuando entra, entonces ve "Todavía no tienes series. Crea la primera."
- **CA-2** Dado el formulario de serie nueva con el nombre "Charlas de datos", cuando la guarda, entonces la serie aparece en la lista con 0 ediciones.
- **CA-3** Dado el nombre vacío, cuando guarda, entonces ve "Escribe el nombre de la serie" y no se crea ninguna serie.
- **CA-4** Dado los datos simulados, cuando Laura Gómez abre "Ciclo de charlas de analítica de datos", entonces ve las ediciones 4, 3, 2 y 1, en ese orden.
- **CA-5** Dado los datos simulados, cuando Laura Gómez entra, entonces ve 2 series y no ve "Club de lectura de ingeniería", que es de Jorge Ramírez.

## Fuera de alcance

- Editar, archivar o borrar una serie.

## Preguntas abiertas

- ¿Una serie debería guardar su frecuencia (mensual, trimestral) en vez de deducirla de las fechas?

## Historial

- 0.1.0 · 2026-11-08 · Primera versión.
