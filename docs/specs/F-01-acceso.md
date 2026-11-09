---
id: F-01
titulo: Acceso a la cuenta
version: 0.1.0
fecha: 2026-11-08
estado: borrador
autores: [Álvaro José Roa Álvarez]
requisitos: [RF-18]
depende_de: []
---

# F-01 · Acceso a la cuenta

## Objetivo

Organizadores e invitados entran con su correo y su contraseña, y cada uno llega a lo que le corresponde según su rol.

## Flujo principal

1. La persona escribe su correo y su contraseña y pide entrar.
2. El sistema verifica los datos.
3. Si la cuenta es de organizador, el sistema muestra sus series (F-02). Si es de invitado, muestra los eventos publicados (F-10).

## Flujos alternos

- **A1 · Crear cuenta:** la persona elige "Crear cuenta", escribe nombre, correo y contraseña, y elige "Organizo eventos" o "Asisto a eventos". El sistema crea la cuenta y vuelve al inicio de sesión con el correo ya escrito.
- **A2 · Datos incorrectos:** el sistema muestra "Correo o contraseña incorrectos" y conserva el correo escrito.
- **A3 · Cerrar sesión:** desde su perfil, la persona cierra la sesión y vuelve al inicio de sesión. El botón atrás no la regresa a la app.

## Reglas

- El correo lleva "@" y un punto después de la "@". La contraseña tiene 6 caracteres o más.
- Un correo pertenece a una sola cuenta.
- El rol se elige al crear la cuenta y no cambia.
- En el perfil se ven el nombre, el correo y el rol.

## Estados

- **Cargando:** el botón muestra "Entrando…" y no se puede volver a tocar.
- **Vacío:** no aplica.
- **Error:** el mensaje aparece debajo del formulario y lo escrito se conserva.

## Datos

- Cuenta: nombre, correo, contraseña y rol.

## Criterios de aceptación

- **CA-1** Dado la cuenta de organizadora de Laura Gómez, cuando entra con su correo y su contraseña, entonces ve la lista de sus series.
- **CA-2** Dado la cuenta de invitada de Valentina Ríos, cuando entra, entonces ve los eventos publicados.
- **CA-3** Dado una contraseña equivocada, cuando la persona intenta entrar, entonces ve "Correo o contraseña incorrectos" y su correo sigue escrito.
- **CA-4** Dado un correo que ya tiene cuenta, cuando alguien crea una cuenta con él, entonces ve "Ese correo ya tiene una cuenta" y no se crea nada.
- **CA-5** Dado una contraseña de 4 caracteres, cuando alguien crea una cuenta, entonces ve "La contraseña debe tener al menos 6 caracteres".
- **CA-6** Dado una sesión abierta, cuando la persona la cierra, entonces vuelve al inicio de sesión y el botón atrás no la lleva de nuevo a la app.

## Fuera de alcance

- Recuperar la contraseña.
- Entrar con una cuenta de Google.
- Cambiar el rol de una cuenta.

## Preguntas abiertas

- ¿Hay que verificar el correo antes de dejar entrar?

## Historial

- 0.1.0 · 2026-11-08 · Primera versión.
