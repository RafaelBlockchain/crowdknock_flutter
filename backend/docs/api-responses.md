
# 📘 API RESPONSES – CrowdKnock Backend

Esta guía documenta las respuestas esperadas por el frontend Flutter al consumir la API REST protegida con JWT.  
**Todas las rutas requieren autenticación** con:

```
Authorization: Bearer <token>
Content-Type: application/json
```

---

## 🔐 AUTH

### POST /auth/login

**Request:**

```json
{
  "email": "admin@example.com",
  "password": "admin123"
}
```

**Response 200:**

```json
{
  "success": true,
  "data": {
    "token": "<JWT>",
    "user": {
      "id": "uuid",
      "name": "Admin",
      "email": "admin@example.com",
      "role": "admin"
    }
  }
}
```

---

### GET /auth/me

**Response 200:**

```json
{
  "success": true,
  "data": {
    "id": "uuid",
    "name": "Admin",
    "email": "admin@example.com",
    "role": "admin"
  }
}
```

---

## 📈 METRICS

### GET /metrics/daily

```json
{
  "success": true,
  "data": [
    {
      "date": "2025-07-08",
      "active_users": 123,
      "session_duration_avg": 146.7,
      "crash_count": 1
    }
  ]
}
```

---

### GET /metrics/users

```json
{
  "success": true,
  "data": {
    "totalUsers": 1043,
    "activeUsers": 812,
    "newUsersToday": 23
  }
}
```

---

### GET /metrics/content

```json
{
  "success": true,
  "data": {
    "totalContent": 950,
    "approved": 840,
    "pending": 60,
    "rejected": 50
  }
}
```

---

### GET /metrics/challenges

```json
{
  "success": true,
  "data": {
    "totalChallenges": 180,
    "active": 35,
    "completed": 140
  }
}
```

---

## 📦 CONTENT

### GET /content

```json
{
  "success": true,
  "data": [
    {
      "id": "uuid",
      "title": "Video de protesta",
      "type": "video",
      "status": "approved",
      "created_at": "2025-07-07T12:00:00Z"
    }
  ]
}
```

---

## 🚨 REPORTS

### GET /reports

```json
{
  "success": true,
  "data": [
    {
      "id": "uuid",
      "type": "content",
      "targetId": "uuid",
      "reason": "Incitación a violencia",
      "status": "pending",
      "created_at": "2025-07-08T09:30:00Z"
    }
  ]
}
```

🛡️ MODERATION
GET /moderation/reported-content
json
Copiar
Editar
{
  "success": true,
  "data": [
    {
      "id": "uuid",
      "contentId": "uuid",
      "type": "video",
      "reportCount": 5,
      "status": "pending",
      "reportedAt": "2025-07-08T10:30:00Z"
    }
  ]
}
POST /moderation/resolve
Request:

json
Copiar
Editar
{
  "reportId": "uuid",
  "action": "approve"
}
Response:

json
Copiar
Editar
{
  "success": true,
  "message": "Report resolved successfully"
}
👥 USERS
GET /users
json
Copiar
Editar
{
  "success": true,
  "data": [
    {
      "id": "uuid",
      "name": "John Doe",
      "email": "john@example.com",
      "role": "user",
      "status": "active",
      "created_at": "2025-07-01T09:00:00Z"
    }
  ]
}
PATCH /users/:id/role
json
Copiar
Editar
{
  "role": "moderator"
}
json
Copiar
Editar
{
  "success": true,
  "message": "User role updated"
}
⚙️ SETTINGS
GET /settings
json
Copiar
Editar
{
  "success": true,
  "data": {
    "maintenanceMode": false,
    "allowRegistrations": true
  }
}
PATCH /settings
json
Copiar
Editar
{
  "maintenanceMode": true
}
json
Copiar
Editar
{
  "success": true,
  "message": "Settings updated"
}
🧩 CHALLENGES
GET /challenges
json
Copiar
Editar
{
  "success": true,
  "data": [
    {
      "id": "uuid",
      "title": "Desafío por el agua",
      "status": "active",
      "participants": 42,
      "created_at": "2025-07-01T08:00:00Z"
    }
  ]
}
POST /challenges
json
Copiar
Editar
{
  "title": "Nuevo desafío",
  "description": "Descripción del reto",
  "deadline": "2025-07-15T23:59:00Z"
}
json
Copiar
Editar
{
  "success": true,
  "message": "Challenge created successfully"
}
💳 PAYMENTS
GET /payments
json
Copiar
Editar
{
  "success": true,
  "data": [
    {
      "id": "uuid",
      "userId": "uuid",
      "amount": 5000,
      "currency": "COP",
      "status": "completed",
      "created_at": "2025-07-08T11:00:00Z"
    }
  ]
}
POST /payments
json
Copiar
Editar
{
  "userId": "uuid",
  "amount": 10000,
  "currency": "COP"
}
json
Copiar
Editar
{
  "success": true,
  "message": "Payment processed"
}
🧭 SYSTEM STATUS
GET /system-status
json
Copiar
Editar
{
  "success": true,
  "data": {
    "uptime": "48h",
    "cpu_usage": 23.5,
    "memory_usage": 63.2,
    "services": {
      "database": "online",
      "storage": "online",
      "auth": "online"
    }
  }
}
POST /system-status/logs
json
Copiar
Editar
{
  "service": "auth",
  "message": "Token verification delay",
  "level": "warning"
}
json
Copiar
Editar
{
  "success": true,
  "message": "Log registered"
}
❌ ERROR GENÉRICO
json
Copiar
Editar
{
  "success": false,
  "error": "Mensaje claro para mostrar en UI"
}
✅ Headers obligatorios
http
Copiar
Editar
Authorization: Bearer eyJhbGciOi...
Content-Type: application/json
