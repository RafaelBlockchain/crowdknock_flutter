# 🚀 CrowdKnock Flutter

**CrowdKnock** es una plataforma de participación ciudadana que permite a usuarios interactuar con contenidos, participar en desafíos, reportar problemáticas y gestionar pagos, todo desde una aplicación Flutter multiplataforma (web, Android, iOS).

Este repositorio contiene la versión **Flutter Web** y **Flutter App móvil** del proyecto.

---

## 📱 Plataformas Soportadas

- ✅ Flutter Web (`flutter build web`)
- ✅ Android (`flutter build apk`)
- ✅ iOS (revisar integración)
- ✅ GitHub Pages (hosting del build web)

---

## 🗂️ Estructura del Proyecto

```bash
crowdknock_flutter/
├── android/                # Proyecto Android
├── assets/                # Imágenes, íconos y recursos
├── lib/
│   ├── core/              # Servicios, widgets reutilizables
│   ├── features/          # Módulos por funcionalidad (auth, dashboard, etc.)
│   └── app.dart           # Configuración general de la app
├── web/                   # Archivos para Flutter Web (incluye index.html)
├── build/                 # Salida del build web (generado por `flutter build web`)
├── .env                   # Variables de entorno (no subir a Git)
├── .env.example           # Ejemplo de configuración
├── .gitignore
├── pubspec.yaml
└── README.md              # Este archivo
