
# 🧠 CrowdKnock Backend

Este es el backend del proyecto **CrowdKnock**, construido con **Node.js + Express** y una base de datos **PostgreSQL**. La aplicación utiliza autenticación con **JWT**, separación por capas, y una arquitectura modular orientada a servicios.

---

## 📁 Estructura del proyecto

```
backend/
├── .env                   # Variables de entorno (producción)
├── .env.example           # Ejemplo de configuración
├── .env.test              # Configuración para pruebas
├── Dockerfile             # Imagen Docker del backend
├── Makefile               # Comandos de automatización
├── package.json           # Dependencias del proyecto
├── server.js              # Entry point del servidor
├── db/                    # Inicialización y seeds de base de datos
├── docs/                  # Documentación (Swagger, respuestas)
├── scripts/               # Scripts CLI para dev y testing
└── src/                   # Código fuente principal
    ├── app.js             # Configuración principal de la app Express
    ├── config/            # Configuración (DB, entorno)
    ├── controllers/       # Lógica de controladores
    ├── docs/              # Swagger auto-generado
    ├── middlewares/       # Middlewares de autenticación, errores, validación
    ├── models/            # Modelos Sequelize
    ├── routes/            # Rutas protegidas
    ├── services/          # Lógica de negocio reutilizable
    └── utils/             # Utilidades generales (email, JWT, etc.)
```

---

## 🛠️ Instalación y ejecución local

1. **Clonar el repositorio**

```bash
git clone https://github.com/tu-usuario/CrowdKnock.git
cd backend
```

2. **Instalar dependencias**

```bash
npm install
```

3. **Crear archivo `.env`**

```bash
cp .env.example .env
```

4. **Iniciar base de datos y poblarla (PostgreSQL debe estar corriendo)**

```bash
node db/init.js
node db/seed.js
```

5. **Levantar el servidor en desarrollo**

```bash
npm run dev
```

---

## 🧪 Tests

Se utilizan herramientas como `jest` para pruebas.

```bash
npm test
```

---

## 📦 Scripts disponibles

Desde la carpeta raíz:

| Script                         | Descripción                                      |
|-------------------------------|--------------------------------------------------|
| `node db/init.js`             | Crea las tablas en la base de datos             |
| `node db/seed.js`             | Poblado inicial con datos de prueba             |
| `npm run dev`                 | Levanta el servidor con nodemon                 |
| `npm test`                    | Ejecuta los tests                               |
| `node scripts/reset.js`       | Reinicia y repuebla la base de datos            |
| `node scripts/migrate.js`     | Ejecuta migraciones (manual o automática)       |
| `node scripts/resetTestDb.js` | Reinicia la base de datos de testing            |
| `node scripts/syncModels.js`  | Sincroniza los modelos Sequelize                |

---

## 🔒 Autenticación

Todas las rutas están protegidas por JWT. Se requiere el token en el encabezado:

```http
Authorization: Bearer <token>
```

---

## 📘 API Docs

Disponible en: `http://localhost:3000/api/docs` (Swagger UI)

Fuente: `docs/swagger.yaml`

---

## 🐳 Docker

Para ejecutar con Docker:

```bash
docker build -t crowdknock-backend .
docker run -p 3000:3000 --env-file .env crowdknock-backend
```

---

## 📂 Rutas disponibles

| Ruta base              | Archivo                           |
|------------------------|-----------------------------------|
| `/api/auth`            | `auth.routes.js`                  |
| `/api/users`           | `users.routes.js`                 |
| `/api/content`         | `content.routes.js`               |
| `/api/reports`         | `reports.routes.js`               |
| `/api/payments`        | `payments.routes.js`              |
| `/api/moderation`      | `moderation.routes.js`            |
| `/api/challenges`      | `challengesRoutes.js`             |
| `/api/metrics`         | `metricsRoutes.js`                |
| `/api/system-status`   | `system_status.routes.ts`         |

---

## ✍️ Contribuciones

Las contribuciones están abiertas. Asegúrate de abrir un *issue* o *pull request* siguiendo el estilo del proyecto.

---

## 🧠 Licencia

MIT © [CrowdKnock]

