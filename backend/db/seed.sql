-- Inserta usuarios
INSERT INTO users (id, name, email, role, is_banned)
VALUES 
  ('user-001', 'Admin Principal', 'admin@example.com', 'admin', false),
  ('user-002', 'Moderador Uno', 'mod1@example.com', 'moderator', false),
  ('user-003', 'Usuario Activo', 'user1@example.com', 'user', false);

-- Inserta contenido
INSERT INTO content (id, title, type, status, user_id)
VALUES 
  ('content-001', 'Video sobre reciclaje', 'video', 'approved', 'user-003'),
  ('content-002', 'Historia sobre cambio climático', 'story', 'pending', 'user-003');

-- Inserta desafíos
INSERT INTO challenges (id, title, description, is_active)
VALUES 
  ('challenge-001', 'Reto: Sin plástico por 7 días', 'Participa sin usar plástico', true),
  ('challenge-002', 'Caminata ecológica', 'Organiza una caminata de limpieza', false);

-- Inserta reportes
INSERT INTO reports (id, type, target_id, reason, status, created_by)
VALUES
  ('report-001', 'content', 'content-001', 'Contenido ofensivo', 'open', 'user-002'),
  ('report-002', 'comment', 'comment-009', 'Lenguaje inapropiado', 'resolved', 'user-003');

-- Inserta métricas simuladas
INSERT INTO app_metrics (id, key, value, timestamp)
VALUES
  ('metric-001', 'active_users', 230, NOW()),
  ('metric-002', 'average_session_time', 12.5, NOW()),
  ('metric-003', 'crash_reports', 3, NOW());
