# 🧠 CrowdKnock Admin Panel (frontend-admin)

Panel administrativo oficial de **CrowdKnock**, construido en **Flutter Web** para la gestión avanzada de usuarios, contenido, moderación, reportes, pagos, métricas, feedback y configuración global.

---

## 📦 Stack Tecnológico

- ✅ **Flutter Web**
- ✅ **Dart**
- ✅ **GoRouter** (en proceso de integración)
- ✅ **JWT Auth** con backend Express
- ✅ **HTTP Client personalizado**
- ✅ Arquitectura modular y escalable

---

## 🗂️ Estructura de Carpetas

lib/
├── core/
│ ├── constants/ # Colores, textos y rutas API
│ ├── layouts/ # AdminLayout base
│ ├── services/ # Servicios HTTP conectados al backend
│ ├── widgets/ # Componentes reutilizables UI
├── features/
│ ├── auth/ # Login, registro, controlador
│ ├── users/ # Gestión de usuarios
│ ├── roles/ # Gestión de roles
│ ├── content/ # Moderación de contenido
│ ├── audit/ # Logs de actividad
│ ├── moderation/ # Moderación centralizada
│ ├── reports/ # Reportes de usuarios
│ ├── payments/ # Panel de pagos
│ ├── feedback/ # Feedback de usuarios
│ ├── settings/ # Configuración general
│ └── core/utils/ # Cliente HTTP con token y manejo de errores

---

## 🔐 Autenticación

- Login y registro de administradores
- Gestión de sesión con JWT token
- Protecciones en servicios (`HttpClient`) automáticas

---

## 🔗 Conexión al Backend (API REST)

Todas las llamadas se hacen usando `HttpClient` centralizado con JWT incluido.

### 📄 `ApiRoutes.dart`

```dart
class ApiRoutes {
  // 🔐 Auth
  static const String login = '/auth/login';
  static const String logout = '/auth/logout';

  // 👥 Users
  static const String users = '/users';
  static String userById(int id) => '/users/$id';

  // 📦 Content
  static const String contentAll = '/content';
  static const String content = '/content';
  static String contentById(int id) => '/content/$id';

  // ⚖️ Moderation
  static const String moderationPending = '/moderation/pending';
  static const String moderationAction = '/moderation/action';

  // 📊 Metrics
  static const String globalMetrics = '/metrics/global';
  static const String userGrowth = '/metrics/user-growth';
  static const String contentActivity = '/metrics/content-activity';
  static const String topCategories = '/metrics/top-categories';

  // 📨 Reports
  static const String userReports = '/reports/user';
  static const String resolveReport = '/reports/resolve';

  // ✉️ Email Templates
  static const String emailTemplates = '/emails/templates';
  static const String updateEmailTemplate = '/emails/templates/update';

  // 💳 Payments
  static const String paymentsList = '/payments';

  // 💬 Feedback
  static const String feedback = '/feedback';
  static const String feedbackAll = '/feedback/all';
  static String feedbackById(int id) => '/feedback/$id';

  // ⚙️ Settings
  static const String getSettings = '/settings';
  static const String updateSettings = '/settings/update';
}
🧪 Scripts de desarrollo
bash
Copiar
Editar
# Instalar dependencias
flutter pub get

# Ejecutar en navegador
flutter run -d chrome

# Build para producción web
flutter build web
✅ Funcionalidades actuales
 Login y registro

 Listado de usuarios y roles

 Panel de contenido y moderación

 Logs de actividad en tiempo real

 Feedback de usuarios

 Reportes y resolución

 Gestión de pagos

 Plantillas de email

 Configuración general de la app

 Arquitectura lista para escalado

📌 Roadmap sugerido
 Integrar GoRouter completo

 CRUD completo de contenido

 Roles con permisos visuales

 Soporte multilenguaje

 Exportar reportes y métricas a PDF/CSV

 Integración con notificaciones en tiempo real

🧠 Contribución
Fork y clona el proyecto

Crea tu rama (git checkout -b feature/nueva-funcionalidad)

Confirma y haz push

Envía PR

📬 Contacto
Este panel es parte del ecosistema CrowdKnock.
Desarrollado por RafaelBlockchain 🚀


