# 📘 API RESPONSES – CrowdKnock Backend

Esta guía documenta las respuestas esperadas por el frontend Flutter al consumir la API REST protegida con JWT. Todas las rutas requieren autenticación con:


---

## 🔐 AUTH

### POST /auth/login

**Request:**

```json
{
  "email": "admin@example.com",
  "password": "admin123"
}

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

{
  "success": true,
  "data": {
    "id": "uuid",
    "name": "Admin",
    "email": "admin@example.com",
    "role": "admin"
  }
}

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

{
  "success": true,
  "data": {
    "totalUsers": 1043,
    "activeUsers": 812,
    "newUsersToday": 23
  }
}

{
  "success": true,
  "data": {
    "totalContent": 950,
    "approved": 840,
    "pending": 60,
    "rejected": 50
  }
}

{
  "success": true,
  "data": {
    "totalChallenges": 180,
    "active": 35,
    "completed": 140
  }
}

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

{
  "success": false,
  "error": "Mensaje claro para mostrar en UI"
}

Authorization: Bearer eyJhbGciOi...
Content-Type: application/json
