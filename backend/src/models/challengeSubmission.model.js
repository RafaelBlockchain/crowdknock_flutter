CREATE TABLE challenge_submissions (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id UUID REFERENCES users(id),
  challenge_id UUID REFERENCES challenges(id),
  comment TEXT NOT NULL,
  file_path TEXT,
  created_at TIMESTAMP DEFAULT now()
);
