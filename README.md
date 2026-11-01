# Cuentas de la casa

App web mínima para llevar las cuentas entre dos personas. Es un solo `index.html` que usa Supabase para el login, los datos y el tiempo real.

## 1. Preparar Supabase (una vez)

1. **Tablas:** si `people` y `expenses` todavía no existen, abre **SQL Editor**, pega el contenido de `schema.sql` y ejecútalo. Así quedan creadas las tablas, las políticas RLS (solo los usuarios con sesión iniciada pueden leer y escribir) y el tiempo real activado.
2. **Usuarios:** ve a **Authentication → Users → Add user** y crea las dos cuentas con email y contraseña. Marca *Auto Confirm User*.
3. **Cierra el registro (importante):** ve a **Authentication → Sign In / Providers** y desactiva *Allow new users to sign up*. La app no tiene pantalla de registro, pero con la clave pública cualquiera podría crear una cuenta llamando directo a la API y leer tus datos.

## 2. Publicar en GitHub Pages

1. Crea un repositorio en GitHub (por ejemplo `cuentas-casa`). Puede ser privado si tienes un plan que lo permita; si no, déjalo público.
2. Sube los archivos de esta carpeta:
   ```sh
   git init && git add . && git commit -m "Cuentas de la casa"
   git branch -M main
   git remote add origin https://github.com/TU_USUARIO/cuentas-casa.git
   git push -u origin main
   ```
3. En el repositorio, ve a **Settings → Pages**. En *Source*, elige **Deploy from a branch**, rama `main` y carpeta `/ (root)`. Guarda.
4. En uno o dos minutos la app queda en `https://TU_USUARIO.github.io/cuentas-casa/`.
5. En Supabase, ve a **Authentication → URL Configuration** y pon esa dirección en *Site URL*. Agrégala también en *Redirect URLs* (`https://cfariasp93-arch.github.io/Cuentas-CASA-FF/`): es a donde vuelve el enlace de "Olvidé mi contraseña".

## 3. Instalar en el celular

- **iPhone (Safari):** botón Compartir → *Agregar a pantalla de inicio*.
- **Android (Chrome):** menú ⋮ → *Agregar a pantalla principal* o *Instalar app*.

## Probar localmente

```sh
python3 -m http.server 8000
```
Luego abre http://localhost:8000.

## Notas

- La clave del `index.html` es la *publishable/anon*, que está hecha para ir en el navegador. Lo que protege tus datos es la RLS. Nunca pongas ahí la `service_role`.
- "¿Quién eres?" se guarda en cada dispositivo. Se puede cambiar desde el menú ⋯.
- **Olvidé mi contraseña:** envía un correo con un enlace que abre la app publicada (constante `APP_URL` en `index.html`) para crear una contraseña nueva. Con el correo por defecto de Supabase se pueden enviar pocos correos por hora; si no llega, espera un rato o configura un SMTP propio en **Authentication → Emails**.
- **Gráficos y Excel:** están hechos sin librerías externas. El Excel (.xlsx) se genera en el mismo navegador, con tres hojas: Movimientos, Resumen por mes y Saldo.
- Los montos se muestran con formato chileno (`$15.000`). Para cambiarlo, edita la función `fmt` en `index.html`.
# Cuentas-CASA-FF
