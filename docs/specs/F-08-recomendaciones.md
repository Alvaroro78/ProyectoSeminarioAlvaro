---
id: F-08
titulo: Recomendaciones de la edición
version: 0.1.0
fecha: 2026-11-08
estado: borrador
autores: [Álvaro José Roa Álvarez]
requisitos: [RF-12, RF-13, RF-14, RF-16, RF-17]
depende_de: [F-03, F-06, F-07]
---

# F-08 · Recomendaciones de la edición

## Objetivo

Con lo aprendido en las ediciones cerradas, el sistema propone cambios concretos a la edición que se está preparando, cada uno con el dato que lo justifica, para que el organizador decida con evidencia.

## Flujo principal

1. El organizador abre una edición en borrador o publicada.
2. El sistema toma el historial: las 3 últimas ediciones cerradas de la serie con número menor que el de la edición abierta.
3. El sistema evalúa las reglas R1, R2, R3 y R5 (R4 está en F-09) y muestra una tarjeta por cada recomendación que aplica, con lo que propone, la evidencia con números y las opciones Aceptar y Descartar.
4. Si el organizador acepta, el sistema aplica el cambio y quita la tarjeta. Si descarta, solo quita la tarjeta.
5. La decisión queda guardada: esa recomendación no vuelve a aparecer en esa edición.

## Flujos alternos

- **A1 · Historial insuficiente:** con menos de 2 ediciones cerradas, el sistema muestra "Se necesitan 2 ediciones cerradas para recomendar. Esta serie tiene N."
- **A2 · Edición cerrada:** no se muestran recomendaciones.
- **A3 · Nada que recomendar:** "Sin recomendaciones: esta edición ya recoge lo aprendido."

## Reglas

H es el historial del paso 2. Los porcentajes se muestran redondeados al entero.

- **Tasa de asistencia** = asistentes de H ÷ inscritos de H.
- **R1 · Cupo.** Si la tasa es menor que 0,9: cupo sugerido = parte entera de (capacidad ÷ tasa). Aparece si el cupo actual es menor que el sugerido.
  - Evidencia: "En las últimas N ediciones asistieron A de I inscritos (P %). Para llenar C lugares, abre S cupos."
  - Aceptar: el cupo pasa a S.
- **R2 · Tareas que se atrasan** (una tarjeta por tarea). Para cada tarea pendiente de la edición cuyo título aparece en H, se toman las ediciones de H donde esa tarea se marcó hecha y se calcula su retraso (F-06). Si se atrasó en 2 o más de ellas: días sugeridos = días actuales − (promedio de retrasos, redondeado hacia arriba). Aparece si los días actuales son mayores que los sugeridos.
  - Evidencia: "Se completó tarde en X de Y ediciones, en promedio Z días."
  - Aceptar: la tarea pasa a los días sugeridos.
- **R3 · Preguntas que casi nadie responde** (una tarjeta por pregunta). Para cada pregunta opcional de la edición cuya etiqueta aparece en H: tasa de respuesta = respuestas no vacías ÷ inscritos de las ediciones de H que tenían esa pregunta. Aparece si la tasa es menor que 20 % y nadie ha respondido esa pregunta en la edición actual.
  - Evidencia: "Solo R de I inscritos la respondieron (P %)."
  - Aceptar: se quita la pregunta.
- **R5 · Asistencia esperada.** Si la edición tiene inscritos: esperados = inscritos × tasa, redondeado hacia arriba.
  - Evidencia: "Con N inscritos y una asistencia histórica del P %, espera E asistentes."
  - Aceptar: se agrega la tarea "Ajustar la logística para E asistentes" en D-2, con responsable "Logística", no heredada.
- Las preguntas obligatorias nunca se recomiendan para quitar.
- Una decisión guarda la regla, la referencia (título de la tarea o etiqueta de la pregunta), si se aceptó y la fecha.

## Estados

- **Cargando:** "Calculando recomendaciones…".
- **Vacío:** los mensajes de A1 y A3.
- **Error:** "No se pudieron calcular las recomendaciones." El resto de la edición se puede seguir usando.

## Datos

- Edición actual, historial de la serie, decisiones de la edición.

## Criterios de aceptación

Con los datos simulados y hoy = 8 nov 2026:

- **CA-1** Dado la edición 4 (capacidad 20, cupo 20) y un historial donde asistieron 41 de 58 inscritos, cuando el organizador la abre, entonces ve la recomendación de abrir 28 cupos y, al aceptarla, el cupo queda en 28.
- **CA-2** Dado la edición 4, cuando el organizador la abre, entonces ve recomendaciones para "Publicar la invitación" (D-10 a D-13) y "Enviar el agradecimiento" (D+2 a D+1), y ninguna para "Reservar el auditorio", que ya está hecha.
- **CA-3** Dado la edición 5 recién creada desde la 4 sin aceptar nada, cuando el organizador la abre, entonces también ve "Reservar el auditorio" (D-21 a D-25).
- **CA-4** Dado la edición 4, cuando el organizador la abre, entonces no ve recomendaciones de quitar preguntas, porque "Cargo" y "¿Cómo te enteraste del evento?" ya tienen respuestas en la 4. Dado la edición 5, entonces ve quitar "Cargo" (8 de 58, 14 %) y "¿Cómo te enteraste del evento?" (9 de 58, 16 %).
- **CA-5** Dado la edición 4 con 8 inscritos, cuando el organizador la abre, entonces ve "espera 6 asistentes" y, al aceptarla, aparece la tarea "Ajustar la logística para 6 asistentes" en D-2.
- **CA-6** Dado la recomendación de cupo descartada en la edición 4, cuando el organizador sale de la edición y vuelve a entrar, entonces esa recomendación no aparece.
- **CA-7** Dado la serie "Taller trimestral de primeros auxilios", con 1 edición cerrada, cuando el organizador crea y abre la edición 2, entonces ve "Se necesitan 2 ediciones cerradas para recomendar. Esta serie tiene 1."

## Fuera de alcance

- Recomendaciones con inteligencia artificial.
- Cambiar los umbrales (0,9; 20 %; 2 ediciones; 3 ediciones de historial).

## Preguntas abiertas

- ¿Debería poder deshacerse una decisión?

## Historial

- 0.1.0 · 2026-11-08 · Primera versión.
