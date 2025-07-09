# 📐 CrowdKnock Backend Architecture

Este documento describe la arquitectura del backend de CrowdKnock, basado en Node.js con Express y PostgreSQL, con estructura modular y separación por capas.

---

## 🧱 Estructura de Carpetas Principal

backend/
├── db/ # Scripts de inicialización y seed
├── docs/ # Documentación Swagger y respuestas API
├── scripts/ # Scripts CLI para migraciones y sincronización
├── src/
│ ├── config/ # Configuración de entorno y base de datos
│ ├── controllers/ # Lógica de controladores para cada feature
│ ├── docs/ # Integración Swagger
│ ├── middlewares/ # Middlewares personalizados
│ ├── models/ # Modelos Sequelize
│ ├── routes/ # Rutas agrupadas por módulo
│ ├── services/ # Lógica de negocio desacoplada
│ ├── utils/ # Utilidades como JWT, validaciones, emails
│ ├── app.js # Aplicación Express
│ └── server.js # Entrada del servidor
├── tests/ # Pruebas unitarias y de integración
├── Dockerfile, Makefile # Scripts de despliegue
└── .env* # Variables de entorno

---

## 🧩 Capas de Arquitectura

[Rutas] → [Middlewares] → [Controladores] → [Servicios] → [Modelos]

### 1. **Rutas (`src/routes/`)**
Encargadas de recibir peticiones HTTP y delegar al controlador correspondiente. Ejemplos:
- `auth.routes.js`
- `users.routes.js`

### 2. **Middlewares (`src/middlewares/`)**
Interfieren en el flujo antes de llegar al controlador. Ejemplos:
- `authMiddleware.js`: verifica JWT
- `roleMiddleware.js`: filtra por rol
- `errorHandler.js`: manejo global de errores

### 3. **Controladores (`src/controllers/`)**
Lógica del controlador que recibe datos del request, valida y llama a servicios.

### 4. **Servicios (`src/services/`)**
Contienen la lógica de negocio. Se comunican directamente con modelos o APIs externas.

### 5. **Modelos (`src/models/`)**
Definen la estructura de la base de datos utilizando Sequelize.

---

## 🔐 Flujo de Autenticación

auth.routes.js
↓
auth.controller.js
↓
user.service.js + jwt.js + token.js + email.js
↓
User.js (modelo Sequelize)

Se utiliza JWT para autenticación de usuarios. Los middlewares validan los tokens antes de acceder a rutas protegidas.

---

## 🧪 Testing

Pruebas ubicadas en `tests/`. Estructura por feature (`auth.test.js`, `payments.test.js`, etc). Se utiliza Jest.

---

## 🧰 Scripts útiles

- `scripts/migrate.js`: Ejecuta migraciones
- `scripts/resetTestDb.js`: Resetea la base de datos de pruebas
- `scripts/syncModels.js`: Sincroniza modelos Sequelize

---

## 📊 Documentación API

La documentación Swagger se encuentra en:
- `docs/swagger.yaml`
- Integrada vía `src/docs/swagger.js`

---

## 📎 Diagrama de Arquitectura

El diagrama visual puede encontrarse en:  
[backend_extended_architecture_diagram.png](./backend_extended_architecture_diagram.png)

---

## 📦 Tecnologías Principales

- Node.js + Express
- Sequelize + PostgreSQL
- JWT Auth
- Jest
- Swagger
- Docker (opcional)

---

## ✍️ Autor y Mantenimiento

Desarrollado y mantenido como parte del sistema CrowdKnock Admin.  
Estructura modular lista para escalar.
