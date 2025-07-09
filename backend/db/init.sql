-- Crear esquema principal
CREATE SCHEMA IF NOT EXISTS crowdknock;

-- Usar este esquema por defecto
SET search_path TO crowdknock;

-- Activar extensión para UUIDs
CREATE EXTENSION IF NOT EXISTS "pgcrypto";

-- Tabla de usuarios
CREATE TABLE IF NOT EXISTS users (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  name TEXT NOT NULL,
  email TEXT UNIQUE NOT NULL,
  password TEXT NOT NULL,
  role TEXT DEFAULT 'user',
  is_banned BOOLEAN DEFAULT FALSE,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Tabla de contenidos
CREATE TABLE IF NOT EXISTS content (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  title TEXT NOT NULL,
  type TEXT NOT NULL, -- video, audio, historia
  status TEXT DEFAULT 'active', -- active, removed, flagged
  url TEXT NOT NULL,
  uploaded_by UUID REFERENCES users(id) ON DELETE SET NULL,
  uploaded_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Tabla de reportes
CREATE TABLE IF NOT EXISTS reports (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  content_id UUID REFERENCES content(id) ON DELETE CASCADE,
  reported_by UUID REFERENCES users(id) ON DELETE SET NULL,
  reason TEXT NOT NULL,
  status TEXT DEFAULT 'pending', -- pending, resolved, ignored
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Tabla de desafíos
CREATE TABLE IF NOT EXISTS challenges (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  title TEXT NOT NULL,
  description TEXT,
  start_date DATE,
  end_date DATE,
  status TEXT DEFAULT 'upcoming' -- upcoming, active, closed
);

-- Tabla de métricas
CREATE TABLE IF NOT EXISTS metrics (
  id SERIAL PRIMARY KEY,
  date DATE NOT NULL,
  active_users INT DEFAULT 0,
  session_duration_avg INT DEFAULT 0,
  crash_count INT DEFAULT 0
);

-- Crear tablas iniciales
CREATE TABLE IF NOT EXISTS users (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    name TEXT NOT NULL,
    email TEXT UNIQUE NOT NULL,
    password TEXT NOT NULL,
    role TEXT DEFAULT 'user',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Índices
CREATE INDEX IF NOT EXISTS idx_users_email ON users(email);
CREATE INDEX IF NOT EXISTS idx_content_type ON content(type);
CREATE INDEX IF NOT EXISTS idx_reports_status ON reports(status);
CREATE INDEX IF NOT EXISTS idx_challenges_status ON challenges(status);

-- Usuario admin inicial (correo único evita duplicado)
INSERT INTO users (name, email, password, role)
VALUES (
  'Admin',
  'admin@crowdknock.com',
  '$2a$10$REEMPLAZAR_POR_HASH_BCRYPT_REAL',
  'admin'
)
ON CONFLICT (email) DO NOTHING;
