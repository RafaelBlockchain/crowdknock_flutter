-- Insertar roles iniciales
INSERT INTO roles (name) VALUES 
  ('admin'),
  ('moderator'),
  ('user')
ON CONFLICT (name) DO NOTHING;

-- Insertar usuarios de ejemplo
INSERT INTO users (name, email, password, role_id, banned) VALUES
  ('Admin User', 'admin@example.com', '$2a$10$hashedpasswordhere', (SELECT id FROM roles WHERE name='admin'), FALSE),
  ('Moderator User', 'mod@example.com', '$2a$10$hashedpasswordhere', (SELECT id FROM roles WHERE name='moderator'), FALSE),
  ('Regular User', 'user@example.com', '$2a$10$hashedpasswordhere', (SELECT id FROM roles WHERE name='user'), FALSE)
ON CONFLICT (email) DO NOTHING;

-- Insertar contenido de ejemplo
INSERT INTO content (title, description, url, type, status, user_id) VALUES
  ('Video Sample', 'Sample video description', 'https://example.com/video.mp4', 'video', 'approved', (SELECT id FROM users WHERE email='user@example.com')),
  ('Audio Sample', 'Sample audio description', 'https://example.com/audio.mp3', 'audio', 'approved', (SELECT id FROM users WHERE email='user@example.com')),
  ('Story Sample', 'Sample story description', 'https://example.com/story', 'story', 'pending', (SELECT id FROM users WHERE email='user@example.com'))
ON CONFLICT (title) DO NOTHING;

-- Insertar desafíos (challenges)
INSERT INTO challenges (title, description, start_date, end_date, status) VALUES
  ('First Challenge', 'Complete this first challenge.', NOW(), NOW() + INTERVAL '7 days', 'active'),
  ('Second Challenge', 'Another fun challenge.', NOW() - INTERVAL '10 days', NOW() - INTERVAL '3 days', 'completed')
ON CONFLICT (title) DO NOTHING;

-- Insertar configuraciones básicas
INSERT INTO settings (key, value) VALUES
  ('site_name', 'CrowdKnock'),
  ('support_email', 'support@crowdknock.com')
ON CONFLICT (key) DO NOTHING;


