-- Usar el esquema crowdknock
SET search_path TO crowdknock;

-- Activar extensión para UUID si aún no existe
CREATE EXTENSION IF NOT EXISTS "pgcrypto";

-- ✅ Usuarios
INSERT INTO users (id, name, email, password, role, is_banned)
VALUES 
  (gen_random_uuid(), 'Admin Principal', 'admin@example.com', '$2a$10$HASH_ADMIN', 'admin', false),
  (gen_random_uuid(), 'Moderador Uno', 'mod1@example.com', '$2a$10$HASH_MOD', 'moderator', false),
  (gen_random_uuid(), 'Usuario Activo', 'user1@example.com', '$2a$10$HASH_USER', 'user', false),
  (gen_random_uuid(), 'Alice', 'alice@example.com', '$2a$10$HASH_ALICE', 'user', false),
  (gen_random_uuid(), 'Bob', 'bob@example.com', '$2a$10$HASH_BOB', 'user', false),
  (gen_random_uuid(), 'Carlos', 'carlos@example.com', '$2a$10$HASH_CARLOS', 'moderator', false)
ON CONFLICT (email) DO NOTHING;

-- Insertar usuario admin
INSERT INTO users (id, name, email, password, role)
VALUES (
  gen_random_uuid(),
  'Admin',
  'admin@example.com',
  '$2b$10$6jv...hash',  -- Asegúrate de hashearlo antes
  'admin'
);

-- ✅ Contenido
INSERT INTO content (id, title, type, url, status, uploaded_by)
VALUES 
  (gen_random_uuid(), 'Video sobre reciclaje', 'video', 'https://cdn.crowdknock.com/video-reciclaje.mp4', 'approved', (SELECT id FROM users WHERE email = 'user1@example.com')),
  (gen_random_uuid(), 'Historia sobre cambio climático', 'story', 'https://cdn.crowdknock.com/historia-clima.pdf', 'pending', (SELECT id FROM users WHERE email = 'user1@example.com')),
  (gen_random_uuid(), 'Video ciudadano 1', 'video', 'https://cdn.crowdknock.com/video1.mp4', 'active', (SELECT id FROM users WHERE email = 'alice@example.com')),
  (gen_random_uuid(), 'Audio testimonio 1', 'audio', 'https://cdn.crowdknock.com/audio1.mp3', 'pending', (SELECT id FROM users WHERE email = 'bob@example.com')),
  (gen_random_uuid(), 'Historia comunidad', 'historia', 'https://cdn.crowdknock.com/historia1.pdf', 'active', (SELECT id FROM users WHERE email = 'alice@example.com'));

-- ✅ Desafíos
INSERT INTO challenges (id, title, description, start_date, end_date, status)
VALUES 
  (gen_random_uuid(), 'Reto: Sin plástico por 7 días', 'Participa sin usar plástico', CURRENT_DATE - 7, CURRENT_DATE, 'closed'),
  (gen_random_uuid(), 'Caminata ecológica', 'Organiza una caminata de limpieza', CURRENT_DATE + 1, CURRENT_DATE + 10, 'upcoming');

-- ✅ Reportes (content y comment simulados)
INSERT INTO reports (id, content_id, reported_by, reason, status)
VALUES
  (
    gen_random_uuid(),
    (SELECT id FROM content WHERE title = 'Audio testimonio 1'),
    (SELECT id FROM users WHERE email = 'carlos@example.com'),
    'Contenido ofensivo detectado por AI',
    'pending'
  ),
  (
    gen_random_uuid(),
    (SELECT id FROM content WHERE title = 'Video sobre reciclaje'),
    (SELECT id FROM users WHERE email = 'mod1@example.com'),
    'Contenido ofensivo',
    'open'
  );

-- ✅ Métricas de la app
INSERT INTO metrics (date, active_users, session_duration_avg, crash_count)
VALUES
  (CURRENT_DATE - INTERVAL '2 day', 120, 5, 1),
  (CURRENT_DATE - INTERVAL '1 day', 150, 6, 0),
  (CURRENT_DATE, 200, 7, 0);
