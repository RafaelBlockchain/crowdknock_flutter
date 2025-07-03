CrowdKnock_flutter/ 
├── backend/                        # Servidor Express (API REST) + PostgreSQL + JWT
│   ├── src/
│   │   ├── controllers/            # Lógica de rutas (auth, users, reports, etc)
│   │   ├── middlewares/           # JWT, validaciones, errores
│   │   ├── models/                # Esquemas de datos (Sequelize u ORM usado)
│   │   ├── routes/                # Rutas organizadas por recurso
│   │   ├── services/              # Lógica de negocio
│   │   ├── config/                # Configuración de DB, entorno
│   │   └── index.js               # Entry point del servidor
│   ├── .env
│   └── package.json

├── frontend-app/                  # App Flutter para usuarios (mobile-first)
│   ├── lib/
│   │   ├── main.dart              # Entry point
│   │   ├── app.dart               # Temas, rutas, providers
│   │   ├── core/                  # Reutilizables globales
│   │   │   ├── constants/
│   │   │   ├── widgets/
│   │   │   ├── utils/
│   │   │   └── services/          # Auth, API, notificaciones, etc.
│   │   ├── config/                # env.dart, configuraciones por entorno
│   │   ├── data/
│   │   │   ├── models/            # User, Report, Challenge, etc
│   │   │   ├── repositories/      # Encapsulan lógica de acceso a datos
│   │   │   └── providers/         # REST, Firebase, WebSocket, etc.
│   │   ├── features/
│   │   │   ├── auth/
│   │   │   ├── dashboard/
│   │   │   ├── challenges/
│   │   │   ├── polls/
│   │   │   ├── reports/
│   │   │   ├── admin_panel/       # Acceso limitado para funciones de admin
│   │   │   └── settings/
│   │   └── routes/
│   ├── assets/
│   └── test/

├── frontend-admin/                # Panel web Flutter para administradores
│   ├── lib/
│   │   ├── main.dart              # Entry point
│   │   ├── app.dart               # Temas y rutas
│   │   ├── core/                  # Shared widgets, layouts, helpers
│   │   ├── pages/
│   │   │   ├── dashboard_page.dart
│   │   │   ├── manage_users_page.dart
│   │   │   ├── manage_content_page.dart
│   │   │   ├── moderation_page.dart
│   │   │   ├── reports_page.dart
│   │   │   ├── payments_page.dart ✅
│   │   │   ├── feedback_page.dart
│   │   │   └── settings_page.dart
│   │   └── routes/
│   ├── assets/
│   └── test/

├── docs/                          # Documentación técnica
│   ├── API.md                     # Endpoints disponibles
│   ├── ARCHITECTURE.md            # Esta estructura
│   └── DEPLOYMENT.md              # Guía de despliegue

├── README.md                      # Descripción general del proyecto
└── LICENSE



// DETALLADO DE:

crowdknock_flutter/frontend-app/  
│
├── lib/
│   ├── main.dart                     # Punto de entrada
│   ├── app.dart                      # Configuración general (temas, rutas)
│   ├── core/                         # Componentes compartidos
│   │   ├── constants/                # Constantes globales (colores, strings, assets)
│   │   ├── widgets/                  # Widgets reutilizables (botones, cards)
│   │   ├── utils/                    # Funciones de ayuda (formatos, validaciones)
│   │   └── services/                 # Servicios generales (API, auth, notificaciones)
│   │
│   ├── config/                       # Configs específicas por entorno (dev/prod)
│   │   └── env.dart
│   │
│   ├── data/                         # Acceso a datos
│   │   ├── models/                   # Modelos (User, Challenge, Reporte, etc)
│   │   ├── repositories/             # Lógica de obtención (API, local storage)
│   │   └── providers/                # Providers (Firebase, REST, etc)
│   │
│   ├── features/                     # Módulos del sistema (por dominio)
│   │   ├── auth/                     # Login, registro, auth JWT
│   │   ├── dashboard/                # Pantalla principal del usuario
│   │   ├── challenges/               # Subir/ver desafíos (audio, video, minijuegos)
│   │   ├── polls/                    # Crear/ver encuestas
│   │   ├── reports/                  # Ver denuncias
│   │   ├── admin_panel/              # Panel administrativo (analytics, users, etc)
│   │   └── settings/                 # Ajustes de cuenta, tema, idioma
│   │
│   └── routes/                       # Sistema de navegación centralizado
│       └── app_router.dart
│
├── assets/                          # Imágenes, iconos, fuentes
│
├── test/                            # Pruebas unitarias y widget tests
│
└── pubspec.yaml                     # Dependencias y configuración del proyecto

