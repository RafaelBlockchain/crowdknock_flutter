// scripts/seed.js
require('dotenv').config();
const { Client } = require('pg');
const bcrypt = require('bcryptjs');
const { v4: uuidv4 } = require('uuid');

const DATABASE_URL = process.env.DATABASE_URL;

const client = new Client({
  connectionString: DATABASE_URL,
});

(async () => {
  try {
    await client.connect();
    console.log('✅ Conectado a PostgreSQL');

    const schema = 'crowdknock';
    await client.query(`SET search_path TO ${schema}`);

    // 🧑 Usuarios
    const users = [
      { name: 'Admin', email: 'admin@example.com', password: 'admin123', role: 'admin' },
      { name: 'Moderator', email: 'mod@example.com', password: 'mod123', role: 'moderator' },
      { name: 'Alice', email: 'alice@example.com', password: 'alice123', role: 'user' },
      { name: 'Bob', email: 'bob@example.com', password: 'bob123', role: 'user' },
    ];

    const userIds = {};

    for (const user of users) {
      const id = uuidv4();
      const hashed = await bcrypt.hash(user.password, 10);
      await client.query(
        `INSERT INTO users (id, name, email, password, role) VALUES ($1, $2, $3, $4, $5)
         ON CONFLICT (email) DO NOTHING`,
        [id, user.name, user.email, hashed, user.role]
      );
      userIds[user.email] = id;
    }

    console.log('✅ Usuarios insertados');

    // 📽 Contenido
    const content = [
      {
        title: 'Video ciudadano 1',
        type: 'video',
        url: 'https://cdn.crowdknock.com/video1.mp4',
        uploaded_by: userIds['alice@example.com'],
      },
      {
        title: 'Audio testimonio 1',
        type: 'audio',
        url: 'https://cdn.crowdknock.com/audio1.mp3',
        uploaded_by: userIds['bob@example.com'],
      },
    ];

    const contentIds = {};

    for (const item of content) {
      const id = uuidv4();
      await client.query(
        `INSERT INTO content (id, title, type, url, status, uploaded_by)
         VALUES ($1, $2, $3, $4, $5, $6)`,
        [id, item.title, item.type, item.url, 'active', item.uploaded_by]
      );
      contentIds[item.title] = id;
    }

    console.log('✅ Contenido insertado');

    // 🚩 Reportes
    await client.query(
      `INSERT INTO reports (id, content_id, reported_by, reason, status)
       VALUES ($1, $2, $3, $4, $5)`,
      [
        uuidv4(),
        contentIds['Audio testimonio 1'],
        userIds['mod@example.com'],
        'Contenido ofensivo detectado por IA',
        'pending',
      ]
    );

    console.log('✅ Reporte insertado');

    // 📊 Métricas
    await client.query(
      `INSERT INTO metrics (date, active_users, session_duration_avg, crash_count)
       VALUES
         (CURRENT_DATE - INTERVAL '2 day', 100, 6, 1),
         (CURRENT_DATE - INTERVAL '1 day', 150, 7, 0),
         (CURRENT_DATE, 200, 8, 0)`
    );

    console.log('✅ Métricas insertadas');

    // 🎯 Desafíos
    await client.query(
      `INSERT INTO challenges (id, title, description, start_date, end_date, status)
       VALUES
         ($1, $2, $3, CURRENT_DATE - 7, CURRENT_DATE - 1, 'closed'),
         ($4, $5, $6, CURRENT_DATE + 1, CURRENT_DATE + 7, 'upcoming')`,
      [
        uuidv4(),
        'Reto Recicla Ya',
        'Recoge plástico en tu comunidad',
        uuidv4(),
        'Marcha Verde',
        'Participa limpiando ríos locales',
      ]
    );

    console.log('✅ Desafíos insertados');

    await client.end();
    console.log('✅ Seed finalizado con éxito');
  } catch (err) {
    console.error('❌ Error en seed:', err.message);
    process.exit(1);
  }
})();
