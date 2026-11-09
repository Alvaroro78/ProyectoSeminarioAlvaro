---
documento: requisitos
proyecto: ProyectoSeminarioAlvaro
version: 0.1.0
fecha: 2026-11-08
estado: borrador
basado_en: prd 0.1.0
---

# Requisitos · ProyectoSeminarioAlvaro

## Funcionales

### O-01 · Preparar una edición nueva a partir de la anterior

- **RF-01** El sistema debe permitir que el organizador cree una serie de eventos con nombre y descripción. *Debe*
- **RF-02** El sistema debe permitir que el organizador cree la primera edición de una serie desde cero, con fecha, hora, lugar, capacidad y cupo. *Debe*
- **RF-03** El sistema debe permitir que el organizador cree una edición nueva a partir de la más reciente de la serie, copiando lugar, hora, capacidad, cupo, preguntas del formulario, mensajes y tareas. *Debe*
- **RF-04** El sistema debe proponer la fecha de la edición nueva sumando a la última fecha los días entre las dos últimas ediciones. *Debería*
- **RF-05** El sistema debe calcular la fecha de cada tarea y de cada mensaje a partir de sus días respecto al día del evento. *Debe*
- **RF-06** El sistema debe permitir que el organizador agregue y quite preguntas del formulario de inscripción, de tipo texto, número o sí/no, obligatorias u opcionales. *Debe*
- **RF-07** El sistema debe permitir que el organizador agregue y quite mensajes con variables y vea su vista previa con las variables reemplazadas. *Debe*
- **RF-08** El sistema debe permitir que el organizador marque un mensaje como enviado. *Debería*
- **RF-09** El sistema debe permitir que el organizador agregue y quite tareas con responsable y días respecto al evento, y las marque como hechas. *Debe*
- **RF-10** El sistema debe mostrar en cada edición el porcentaje de preguntas, mensajes y tareas heredados de la edición anterior. *Debe*
- **RF-11** El sistema debe permitir que el organizador publique una edición en borrador y cierre una edición publicada. *Debe*

### O-02 · Recomendaciones sacadas de las ediciones pasadas

- **RF-12** El sistema debe sugerir un cupo de inscripción a partir de la tasa de asistencia de las ediciones cerradas. *Debe*
- **RF-13** El sistema debe sugerir adelantar las tareas que se completaron tarde en las ediciones cerradas. *Debe*
- **RF-14** El sistema debe sugerir quitar las preguntas opcionales que casi nadie respondió en las ediciones cerradas. *Debe*
- **RF-15** El sistema debe listar a las personas que asistieron a 2 o más de las ediciones cerradas recientes y no se han inscrito en la edición actual. *Debe*
- **RF-16** El sistema debe estimar cuántos inscritos de la edición actual van a asistir. *Debería*
- **RF-17** El sistema debe permitir que el organizador acepte o descarte cada recomendación; al aceptarla se aplica su cambio. *Debe*

### O-03 · Inscribirse desde el celular

- **RF-18** El sistema debe permitir que una persona cree su cuenta como organizador o como invitado, inicie sesión y la cierre. *Debe*
- **RF-19** El sistema debe permitir que el invitado vea los eventos publicados con fecha, hora, lugar y cupos libres. *Debe*
- **RF-20** El sistema debe permitir que el invitado se inscriba respondiendo el formulario de la edición y reciba un código de inscripción. *Debe*
- **RF-21** El sistema debe permitir que el invitado vea sus inscripciones, con el código y si asistió. *Debe*

### O-04 · Registrar la asistencia

- **RF-22** El sistema debe permitir que el organizador vea los inscritos de una edición y los busque por nombre o por código. *Debe*
- **RF-23** El sistema debe permitir que el organizador marque y desmarque la asistencia de un inscrito. *Debe*

## No funcionales

- **RNF-01** La app funciona en Chrome de escritorio y en Android 10 o superior. (O-03, O-04) *Debe*
- **RNF-02** Todos los textos que ve el usuario están en español. (O-03) *Debe*
- **RNF-03** Crear una edición nueva desde la anterior toma 3 pantallas o menos contando desde la lista de series. (O-01) *Debe*
- **RNF-04** Cada recomendación muestra los números de los que sale, por ejemplo "asistieron 41 de 58 inscritos". (O-02) *Debe*
- **RNF-05** Con 3 ediciones de historial y hasta 200 inscritos por edición, las recomendaciones aparecen en menos de 1 segundo. (O-02) *Debería*
- **RNF-06** Una edición cerrada no se puede modificar. (O-02) *Debe*
- **RNF-07** En un celular de 360 px de ancho ninguna pantalla se corta a lo ancho; en el computador el contenido no pasa de 600 px de ancho. (O-01, O-03) *Debería*
- **RNF-08** Cada organizador ve solo sus series y cada invitado solo sus inscripciones. (O-03, O-04) *Debe*

## Preguntas abiertas

- Si los umbrales de las reglas pasan a ser configurables, ¿quién los cambia y desde dónde?
- ¿La búsqueda de inscritos debe ignorar las tildes?

## Historial

- 0.1.0 · 2026-11-08 · Primera versión.
